return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Continue",
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.toggle()
        end,
        desc = "Toggle REPL",
      },
      {
        "<leader>dK",
        function()
          require("dap.ui.widgets").hover()
        end,
        desc = "Hover",
      },
      {
        "<leader>dt",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle breakpoint",
      },
      {
        "<leader>dso",
        function()
          require("dap").step_over()
        end,
        desc = "Step over",
      },
      {
        "<leader>dsi",
        function()
          require("dap").step_into()
        end,
        desc = "Step into",
      },
      {
        "<leader>dl",
        function()
          require("dap").run_last()
        end,
        desc = "Run last",
      },
    },
  },
  {
    "nvim-telescope/telescope-dap.nvim",
    dependencies = {
      { "mfussenegger/nvim-dap" },
    },
  },
}
