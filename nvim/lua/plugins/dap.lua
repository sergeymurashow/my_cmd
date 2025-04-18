return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "williamboman/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",
      "mxsdev/nvim-dap-vscode-js",
      "nvim-telescope/telescope-dap.nvim",
      "theHamsta/nvim-dap-virtual-text",
    },
    -- Ключевое изменение: добавляем event для ранней загрузки
    event = "VeryLazy",
    init = function()
      -- Устанавливаем keymaps сразу, но они будут работать только после загрузки плагина
      vim.keymap.set("n", "<leader>dc", function()
        require("dap").continue()
      end, { desc = "Debug: Start/Continue" })
      vim.keymap.set("n", "<leader>dt", function()
        require("dap").toggle_breakpoint()
      end, { desc = "Debug: Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>dn", function()
        require("dap").step_over()
      end, { desc = "Debug: Step Over" })
      vim.keymap.set("n", "<leader>di", function()
        require("dap").step_into()
      end, { desc = "Debug: Step Into" })
      vim.keymap.set("n", "<leader>do", function()
        require("dap").step_out()
      end, { desc = "Debug: Step Out" })
      vim.keymap.set("n", "<leader>dr", function()
        require("dap").repl.open()
      end, { desc = "Debug: Open REPL" })
    end,
    config = function()
      require("configs.dap").setup()
      require("plugins.dap.telescope-dap").setup()
      require("plugins.dap.dap-virtual-text").setup()
    end,
  },
}
