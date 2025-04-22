local M = {}

function M.setup()
  -- Проверяем наличие Telescope
  local ok, telescope = pcall(require, "telescope")
  if not ok then
    vim.notify("Telescope not found", vim.log.levels.ERROR)
    return
  end

  -- Настройка расширения DAP ДО его загрузки
  telescope.setup({
    extensions = {
      dap = {
        variables = {
          path_display = { "smart" },
          sorting_strategy = "ascending",
          layout_config = {
            width = 0.8,
            height = 0.6,
          },
        },
      },
    },
  })

  -- Загружаем расширение ПОСЛЕ настройки
  telescope.load_extension("dap")

  -- Настройка keymaps с проверкой
  local set_keymap = function(lhs, rhs, desc)
    vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
  end

  set_keymap("<leader>df", function()
    if pcall(require("telescope").extensions.dap.frames) then
      vim.notify("DAP frames loaded", vim.log.levels.INFO)
    end
  end, "DAP Frames")

  set_keymap("<leader>dbl", function()
    if pcall(require("telescope").extensions.dap.list_breakpoints) then
      vim.notify("DAP breakpoints loaded", vim.log.levels.INFO)
    end
  end, "DAP Breakpoints")

  set_keymap("<leader>dv", function()
    if pcall(require("telescope").extensions.dap.variables) then
      vim.notify("DAP Variables", vim.log.levels.INFO)
    end
  end, "DAP Variables")
end

return M
