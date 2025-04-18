local M = {}

function M.setup()
  -- Убедитесь, что nvim-dap уже загружен
  local dap_ok, _ = pcall(require, "dap")
  if not dap_ok then
    vim.notify("nvim-dap not found", vim.log.levels.WARN)
    return
  end

  -- Правильная настройка плагина
  require("nvim-dap-virtual-text").setup({
    enabled = true,           -- Включить плагин
    enabled_commands = true,  -- Включить команды
    highlight_changed_variables = true,  -- Подсвечивать измененные переменные
    highlight_new_as_changed = true,     -- Новые переменные как измененные
  })
end

return M
