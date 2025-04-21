local telescope = require("telescope.builtin")
local plenary_scan = require("plenary.scandir")

vim.api.nvim_create_user_command("SwapFiles", function()
  local swap_dir = vim.fn.stdpath("state") .. "/swap/" -- Директория для swap-файлов
  if vim.fn.isdirectory(swap_dir) == 0 then
    print("Swap directory does not exist: " .. swap_dir)
    return
  end

  local files = plenary_scan.scan_dir(swap_dir, { depth = 1, add_dirs = false, hidden = true })

  telescope.find_files({
    prompt_title = "Swap Files",
    cwd = swap_dir,
    attach_mappings = function(_, map)
      map("i", "<C-dl>", function(prompt_bufnr)
        local entry = require("telescope.actions.state").get_selected_entry()
        local file = entry.path
        local result = vim.fn.delete(file) -- Удаляем файл
        if result == 0 then
          print("Deleted: " .. file)
        else
          print("Failed to delete: " .. file)
        end
        require("telescope.actions").close(prompt_bufnr)
      end)
      return true
    end,
  })
end, { desc = "Find and manage swap files" })
