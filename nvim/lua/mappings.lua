require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
-- add yours here
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
-- map("n", "<leader>dc", function() require("dap").continue() end, opts)
-- map("n", "<leader>do", function() require("dap").step_over() end, opts)
-- map("n", "<leader>di", function() require("dap").step_into() end, opts)
-- map("n", "<leader>dou", function() require("dap").step_out() end, opts)
-- map("n", "<Leader>db", function() require("dap").toggle_breakpoint() end, opts)
-- map("n", "<Leader>dr", function() require("dap").repl.toggle() end, opts)
-- перемещение строк вверх/вниз в normal и visual
-- map("n", "<C-j>", ":m .+1<CR>==", opts)
-- map("n", "<C-k>", ":m .-2<CR>==", opts)
map("v", "<C-j>", ":m '>+1<CR>gv=gv", opts)
map("v", "<C-k>", ":m '<-2<CR>gv=gv", opts)

-- перемещение курсора в insert-режиме
map("i", "<C-h>", "<Left>", opts)
map("i", "<C-l>", "<Right>", opts)
map("i", "<C-j>", "<Down>", opts)
map("i", "<C-k>", "<Up>", opts)

map("n", "<Tab>", ":bnext<CR>", opts)
map("n", "<S-Tab>", ":bprev<CR>", opts)

map("n", "<leader>tn", ":tabnew<CR>", opts)
map("n", "<leader>tc", ":tabclose<CR>", opts)
map("n", "<leader>tl", ":tabnext<CR>", opts)
map("n", "<leader>th", ":tabprevious<CR>", opts)

map("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

map("n", "<leader>ff", ":Telescope find_files<CR>", opts)
map("n", "<leader>fb", ":Telescope buffers<CR>", opts)
map("n", "<leader>fg", ":Telescope live_grep<CR>", opts)

-- Навигация между окнами (splits)
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

map("n", "<leader>cf", function()
  vim.lsp.buf.format()
end, { desc = "Format Code" })

map("i", "<D-v>", '"+p', { noremap = true, silent = true, desc = "Paste from system clipboard" })
map("c", "<D-v>", '<C-R>+', { noremap = true, silent = true }) -- в командной строке

-- Удаление и изменение без загрязнения буфера
local silent = { noremap = true, silent = true }

map("n", "x", "\"_x", silent)
map("n", "dd", "\"_dd", silent)
map("n", "D", "\"_D", silent)
map("v", "d", "\"_d", silent)
map("n", "c", "\"_c", silent)
map("v", "c", "\"_c", silent)
map("n", "C", "\"_C", silent)

local preview_win = nil

local function preview_nvim_tree_node()
  -- Закрыть предыдущее превью, если есть
  if preview_win and vim.api.nvim_win_is_valid(preview_win) then
    vim.api.nvim_win_close(preview_win, true)
    preview_win = nil
    return
  end

  local ok, api = pcall(require, "nvim-tree.api")
  if not ok then return end

  local node = api.tree.get_node_under_cursor()
  if not node or node.type ~= "file" then return end

  local file_path = node.absolute_path
  local buf = vim.fn.bufadd(file_path)
  vim.fn.bufload(buf)

  local width = math.floor(vim.o.columns * 0.6)
  local height = math.floor(vim.o.lines * 0.6)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  preview_win = vim.api.nvim_open_win(buf, false, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })
end

map("n", "P", preview_nvim_tree_node, { noremap = true, silent = true, desc = "Toggle file preview (nvim-tree)" })

map("n", "<leader>qq", function()
  local modified = false

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_option(buf, "modified") then
      modified = true
      break
    end
  end

  if modified then
    vim.ui.select({ "Нет", "Да" }, { prompt = "Есть несохранённые буферы. Выйти без сохранения?" }, function(choice)
      if choice == "Да" then
        vim.cmd("qa!")
      end
    end)
  else
    vim.cmd("qa")
  end
end, { noremap = true, silent = true, desc = "Confirm quit Neovim" })
