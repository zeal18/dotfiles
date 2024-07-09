-------------------------------------------------------------------------------
-- These are example settings to use with nvim-metals and the nvim built-in
-- LSP. Be sure to thoroughly read the `:help nvim-metals` docs to get an
-- idea of what everything does. Again, these are meant to serve as an example,
-- if you just copy pasta them, then should work,  but hopefully after time
-- goes on you'll cater them to your own liking especially since some of the stuff
-- in here is just an example, not what you probably want your setup to be.
--
-- Unfamiliar with Lua and Neovim?
--  - Check out https://github.com/nanotee/nvim-lua-guide
--
-- The below configuration also makes use of the following plugins besides
-- nvim-metals, and therefore is a bit opinionated:
--
-- - https://github.com/hrsh7th/nvim-cmp
--   - hrsh7th/cmp-nvim-lsp for lsp completion sources
--   - hrsh7th/cmp-vsnip for snippet sources
--   - hrsh7th/vim-vsnip for snippet sources
--
-- - https://github.com/mfussenegger/nvim-dap (for debugging)
-------------------------------------------------------------------------------

-- NOTE: You may or may not want java included here. You will need it if you
-- want basic Java support but it may also conflict if you are using
-- something like nvim-jdtls which also works on a java filetype autocmd.
local filetypes = { "scala", "sbt", "java" }

return {
  {
    "scalameta/nvim-metals",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    },
    lazy = true,
    ft = filetypes,
    keys = {
      {
        "<leader>me",
        function()
          require("telescope").extensions.metals.commands()
        end,
        desc = "Metals commands",
      },
      {
        "<leader>mc",
        function()
          require("metals").compile_cascade()
        end,
        desc = "Metals compile cascade",
      },
      {
        "<leader>mC",
        function()
          require("metals").compile_cancel()
        end,
        desc = "Metals compile cancel",
      },
      {
        "<leader>mi",
        function()
          require("metals").import_build()
        end,
        desc = "Metals import build",
      },
      {
        "<leader>mo",
        function()
          require("metals").organize_imports()
        end,
        desc = "Metals organize imports",
      },
      {
        "<leader>cc",
        function()
          vim.lsp.codelens.run()
        end,
        desc = "Run code lens",
      },
    },
    config = function(_, _)
      local metals = require("metals")
      local metals_config = metals.bare_config()
      metals_config.init_options.statusBarProvider = "on"

      -- Example of settings
      metals_config.settings = {
        showImplicitArguments = false,
        excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
      }
      metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- A hacky workaround for the following issue: https://github.com/scalameta/nvim-metals/issues/417
      metals_config.find_root_dir = function(patterns, startpath)
        return vim.fn.getcwd()
      end

      local dap = require("dap")
      dap.configurations.scala = {
        {
          type = "scala",
          request = "launch",
          name = "RunOrTest",
          metals = {
            runType = "runOrTestFile",
          },
        },
        {
          type = "scala",
          request = "launch",
          name = "Test Target",
          metals = {
            runType = "testTarget",
          },
        },
      }
      dap.listeners.after["event_terminated"]["nvim-metals"] = function()
        dap.repl.open()
      end

      metals_config.on_attach = function(client, bufnr)
        metals.setup_dap()
        -- require("lsp-format").on_attach(client, bufnr)
      end

      -- Autocmd that will actually be in charging of starting the whole thing
      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = filetypes,
        callback = function()
          require("metals").initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
      })
    end,
  },
}
