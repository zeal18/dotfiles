return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
        lua = true,
        scala = true,
        ["*"] = true,
      },
    },
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = {
      "copilot.lua",
      "nvim-lualine/lualine.nvim",
      "hrsh7th/nvim-cmp",
    },
    opts = {},
    config = function(_, opts)
      local lualine = require("lualine")
      local lualine_config = lualine.get_config()
      local Util = require("lazyvim.util")
      local colors = {
        [""] = Util.ui.fg("Special"),
        ["Normal"] = Util.ui.fg("Special"),
        ["Warning"] = Util.ui.fg("DiagnosticError"),
        ["InProgress"] = Util.ui.fg("DiagnosticWarn"),
      }

      local x_size = #lualine_config.sections.lualine_x
      table.insert(lualine_config.sections.lualine_x, x_size + 1, {
        function()
          local icon = require("lazyvim.config").icons.kinds.Copilot
          local status = require("copilot.api").status.data
          return icon .. (status.message or "")
        end,
        cond = function()
          if not package.loaded["copilot"] then
            return
          end
          local ok, clients = pcall(Util.lsp.get_clients, { name = "copilot", bufnr = 0 })
          if not ok then
            return false
          end
          return ok and #clients > 0
        end,
        color = function()
          if not package.loaded["copilot"] then
            return
          end
          local status = require("copilot.api").status.data
          return colors[status.status] or colors[""]
        end,
      })
      lualine.setup(lualine_config)

      local cmp = require("cmp")
      local cmp_opts = cmp.get_config()
      table.insert(cmp_opts.sources, {
        name = "copilot",
        group_index = 0,
        priority = 100,
      })
      cmp.setup(cmp_opts)

      local copilot_cmp = require("copilot_cmp")
      copilot_cmp.setup(opts)
      -- attach cmp source whenever copilot attaches
      -- fixes lazy-loading issues with the copilot cmp source
      require("lazyvim.util").lsp.on_attach(function(client)
        if client.name == "copilot" then
          copilot_cmp._on_insert_enter({})
        end
      end)
    end,
  },
}
