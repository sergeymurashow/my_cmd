local M = {}

-- 🔍 Поиск корня проекта (ищем package.json или node_modules)
local function find_project_root()
  local path = vim.fn.expand "%:p:h" -- директория текущего файла
  local sep = package.config:sub(1, 1)
  local function exists(p)
    return vim.fn.empty(vim.fn.glob(p)) == 0
  end
  while path and #path > 1 do
    if exists(path .. sep .. "package.json") or exists(path .. sep .. "node_modules") then
      return path
    end
    path = vim.fn.fnamemodify(path, ":h")
  end
  return vim.fn.getcwd() -- fallback
end

function M.setup()
  local dap = require "dap"
  local mason_dap = require "mason-nvim-dap"

  mason_dap.setup {
    ensure_installed = { "python", "node2", "js", "pwa-node" },
    automatic_installation = true,
    handlers = {},
  }

  dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
      command = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug-adapter",
      args = { "${port}" },
    },
  }

  dap.configurations.typescript = {
    {
      name = "Debug TS with ts-node",
      type = "pwa-node",
      request = "launch",
      cwd = find_project_root(), -- 👈 динамически
      runtimeExecutable = find_project_root() .. "/node_modules/.bin/ts-node",
      runtimeArgs = { "--transpile-only" },
      args = { "${file}" },
      sourceMaps = true,
      skipFiles = { "<node_internals>/**", "**/node_modules/**" },
      resolveSourceMapLocations = {
        find_project_root() .. "/**",
        "!" .. find_project_root() .. "/node_modules/**",
      },
      smartStep = true,
      console = "integratedTerminal",
      protocol = "inspector",
      envFile = find_project_root() .. "/.env",
    },
  }

  -- UI и keymaps, как раньше
  vim.fn.sign_define("DapBreakpoint", { text = "🌜", texthl = "DiagnosticError" })
  vim.fn.sign_define("DapStopped", { text = "➡️", texthl = "DiagnosticInfo" })

  vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
  vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
  vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
  vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
  vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })

  vim.keymap.set("n", "<leader>dh", function()
    require("dap.ui.widgets").hover()
  end, { desc = "Debug: Hover variables" })

  vim.notify("DAP ready! Root detection active!", vim.log.levels.INFO)
end

return M
