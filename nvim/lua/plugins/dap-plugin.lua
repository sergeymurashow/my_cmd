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

      vim.keymap.set("n", "<leader>dd", ":DapDisconnect<CR>==", { desc = "Debug: Disconnect session" })

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
      vim.keymap.set("n", "<leader>dh", function()
        local widgets = require("dap.ui.widgets")
        widgets.preview()
      end, { desc = "Debug: Preview vars" })
      vim.keymap.set("n", "<Leader>ds", function()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.scopes)
      end, { desc = "Debug: Scopes" })

      -- Trying some features

      local dap = require("dap")
      local widgets = require("dap.ui.widgets")

      -- Переопределение поведения REPL
      dap.defaults.fallback.terminal_win_cmd = "botright 10split new" -- Отключаем стандартное окно

      -- Настройка запуска дебага без отображения окон
      dap.listeners.before.event_initialized["custom_behavior"] = function()
        -- Не открываем окна автоматически
      end

      -- Закрытие окна дебага после завершения сессии
      dap.listeners.after.event_terminated["close_debug"] = function()
        dap.close() -- Закрывает все окна, связанные с дебагом
      end

      dap.listeners.after.event_exited["close_debug"] = function()
        dap.close() -- Закрывает окна, если сессия завершилась
      end

      -- Открыть панель с переменными посередине
      vim.keymap.set("n", "<Leader>dv", function()
        widgets.centered_float(widgets.scopes).toggle()
      end)

      -- Открыть вывод дебага снизу
      vim.keymap.set("n", "<Leader>do", function()
        vim.cmd("botright split | resize 10") -- Создаем окно снизу
        dap.repl.open(nil, "split") -- Открываем вывод в этом окне
      end)

      -- Открыть REPL как всплывающее окно
      vim.keymap.set("n", "<Leader>dr", function()
        widgets.centered_float(require("dap.repl").open()) -- Открытие REPL во всплывающем окне
      end)

      -- Закрытие окна по нажатию 'q'
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "dap-float",
        callback = function()
          vim.api.nvim_buf_set_keymap(0, "n", "q", "<Cmd>close<CR>", { noremap = true, silent = true })
        end,
      })

      -- Автозапуск панелей при старте дебага
      -- dap.listeners.after.event_initialized['custom_ui'] = function()
      --   widgets.sidebar(widgets.scopes).open()
      --   vim.cmd('botright split | resize 10')
      --   dap.repl.open(nil, 'split')
      -- end
    end,
    config = function()
      require("config.dap-config").setup()
      require("plugins.dap.telescope-dap").setup()
      require("plugins.dap.dap-virtual-text").setup()
    end,
  },
}
