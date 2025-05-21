local M = {}
local Breakpoints = {}
Breakpoints.__index = Breakpoints

function Breakpoints.new()
  return setmetatable({ _data = {} }, Breakpoints)
end

function Breakpoints:has(value)
  return self._data[value] ~= nil
end

function Breakpoints:add(key, value)
  self._data[key] = value
end

function Breakpoints:remove(key)
  self._data[key] = nil
end

function Breakpoints:list()
  local result = {}
  for key in pairs(self._data) do
    local value = self._data[key]
    table.insert(result, value)
  end
  return result
end

function Breakpoints:clear()
  self._data = {}
end

local BP = Breakpoints.new()

vim.fn.sign_define("DebugBreakpoint", {
  text = "B",
  texthl = "DebugBreakpoint",
})

function M.toggle_breakpoint()
  local line = vim.fn.line "."
  local fname = vim.fn.expand "%:p"
  local key = fname .. line

  if BP:has(key) then
    BP:remove(key)
    vim.fn.sign_place(0, "test_group", "DebugBreakpoint", fname, { lnum = line })
    vim.notify(key .. " is removed")
  else
    BP:add(key, { file = fname, line = line })
    vim.fn.sign_unplace(fname, { lnum = line })
    vim.notify(key .. " is added")
  end
end

function M.setup()
  vim.api.nvim_create_user_command("AddBp", M.toggle_breakpoint, { desc = "Add breakpoint" })

  vim.keymap.set("n", "<leader>db", M.toggle_breakpoint, { desc = "Add breakpoint" })
  vim.keymap.set("n", "<leader>dt", ":luafile %<CR>==", { desc = "Set this config" })
end

M.setup()
return M
