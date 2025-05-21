local M = {}
local breakpoints = {}

-- Добавить breakpoint в текущей строке файла
function M.add_breakpoint()
  local file = vim.fn.expand "%:p"
  local line = vim.fn.line "."
  table.insert(breakpoints, { file = file, line = line })

  vim.fn.sign_place(0, "debugger", "DebugBreakpoint", file, { lnum = line })
  vim.notify("🔴 Breakpoint added: " .. file .. ":" .. line)
end

-- Удалить все breakpoints
function M.clear_breakpoints()
  breakpoints = {}
  vim.fn.sign_unplace "debugger"
  vim.notify "🚫 All breakpoints cleared"
end

-- Получить список breakpoints (если нужно вручную)
function M.get_breakpoints()
  return breakpoints
end

-- Запустить node inspect с breakpoints и cont
function M.run_inspector()
  local entry_file = vim.fn.expand "%:p"
  if vim.fn.filereadable(entry_file) == 0 then
    vim.notify("❌ File not found: " .. entry_file, vim.log.levels.ERROR)
    return
  end

  vim.cmd "botright split | resize 15 | terminal"
  local term_id = vim.b.terminal_job_id

  vim.fn.chansend(term_id, "node inspect " .. entry_file .. "\n")

  vim.defer_fn(function()
    for _, bp in ipairs(breakpoints) do
      local cmd = "break " .. bp.file .. ":" .. bp.line .. "\n"
      vim.fn.chansend(term_id, cmd)
    end
    vim.fn.chansend(term_id, "cont\n")
  end, 500)
end

-- Автоматическая регистрация команд и биндов
function M.setup()
  vim.api.nvim_create_user_command("BreakpointAdd", M.add_breakpoint, {})
  vim.api.nvim_create_user_command("BreakpointClear", M.clear_breakpoints, {})
  vim.api.nvim_create_user_command("InspectorRun", M.run_inspector, {})

  vim.keymap.set("n", "<leader>b", M.add_breakpoint, { desc = "Add Breakpoint" })
  vim.keymap.set("n", "<leader>dc", M.clear_breakpoints, { desc = "Clear Breakpoints" })
  vim.keymap.set("n", "<leader>di", M.run_inspector, { desc = "Run node inspect" })
end

return M
