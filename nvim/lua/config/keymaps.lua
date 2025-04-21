vim.keymap.set("n", "<C-s>", ":w<CR>", { silent = true })
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a", { silent = true })

vim.keymap.set("n", "<C-k>", ":m .-2<CR>==", { silent = true })
vim.keymap.set("n", "<C-j>", ":m .+1<CR>==", { silent = true })

vim.keymap.set("n", "<leader>db", ':lua require("dap").toggle_breakpoint()<CR>', { silent = true })
vim.keymap.set("n", "<leader>dc", ':lua require("dap").continue()<CR>', { silent = true })
vim.keymap.set("i", "C-x", "C-\\, C-n")

-- Не копировать в буфер при удалении строк
vim.keymap.set("n", "dd", '"_dd', { noremap = true })
vim.keymap.set("n", "D", '"_D', { noremap = true })

-- Для визуального режима тоже
vim.keymap.set("v", "d", '"_d', { noremap = true })
vim.keymap.set("v", "x", '"_x', { noremap = true })
vim.keymap.set("v", "X", '"_X', { noremap = true })
vim.keymap.set("v", "p", '"_dP', { noremap = true }) -- Не копировать при замене в визуальном режиме

-- Явное копирование в системный буфер
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>Y", '"+Y', { desc = "Copy line to system clipboard" })

-- Явная вставка из системного буфера
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set("n", "<leader>P", '"+P', { desc = "Paste before from system clipboard" })

-- -- Navigation
vim.keymap.set("i", "<c-k>", "<UP>")
vim.keymap.set("i", "<c-j>", "<DOWN>")
vim.keymap.set("i", "<c-h>", "<LEFT>")
vim.keymap.set("i", "<c-l>", "<RIGHT>")

-- WhichKey ( Must be last! )
vim.keymap.set("n", "<leader>o", ":Neotree float git_status<CR>")
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = " "
--
-- local map = vim.keymap.set
--
-- -- Дебаг
-- map("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>", { desc = "Toggle breakpoint" })
--
-- -- NeoTree
-- map("n", "<leader>E", ":Neotree float reveal<CR>")
-- map("n", "<leader>e", ":Neotree left reveal<CR>")
-- map("n", "<leader>o", ":Neotree float git_status<CR>")
--
-- -- Navigation
-- map("n", "<c-k>", ":wincmd k<CR>")
-- map("n", "<c-j>", ":wincmd j<CR>")
-- map("n", "<c-h>", ":wincmd h<CR>")
-- map("n", "<c-l>", ":wincmd l<CR>")
-- map("n", "<leader>/", ":CommentToggle<CR>")
--
-- -- Splits
-- map("n", "|", ":vsplit<CR>")
-- map("n", "\\", ":split<CR>")
--
-- -- Other
-- map("n", "<leader>w", ":w<CR>")
-- map("n", "<leader>x", ":BufferLinePickClose<CR>")
-- map("n", "<leader>X", ":BufferLineCloseRight<CR>")
-- map("n", "<leader>s", ":BufferLineSortByTabs<CR>")
-- map("i", "jj", "<Esc>")
-- map("n", "<leader>h", ":nohlsearch<CR>")
--
-- -- Tabs
-- map("n", "<Tab>", ":BufferLineCycleNext<CR>")
-- map("n", "<s-Tab>", ":BufferLineCyclePrev<CR>")
--
-- -- Terminal
-- map("n", "<leader>tf", ":ToggleTerm direction=float<CR>")
-- map("n", "<leader>th", ":ToggleTerm direction=horizontal<CR>")
-- map("n", "<leader>tv", ":ToggleTerm direction=vertical size=40<CR>")
--
-- -- LSP маппинги
-- map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Go to definition" })
-- map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Hover documentation" })
--
-- -- Не копировать в буфер при удалении строк
-- vim.keymap.set("n", "dd", '"_dd', { noremap = true })
-- vim.keymap.set("n", "D", '"_D', { noremap = true })
--
-- -- Для визуального режима тоже
-- vim.keymap.set("v", "d", '"_d', { noremap = true })
-- vim.keymap.set("v", "x", '"_x', { noremap = true })
-- vim.keymap.set("v", "X", '"_X', { noremap = true })
-- vim.keymap.set("v", "p", '"_dP', { noremap = true }) -- Не копировать при замене в визуальном режиме
--
-- -- Явное копирование в системный буфер
-- vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy to system clipboard" })
-- vim.keymap.set({ "n", "v" }, "<leader>Y", '"+Y', { desc = "Copy line to system clipboard" })
--
-- -- Явная вставка из системного буфера
-- vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste from system clipboard" })
-- vim.keymap.set("n", "<leader>P", '"+P', { desc = "Paste before from system clipboard" })
--
-- -- WhichKey ( Must be last! )
-- map("n", "<leader>o", ":Neotree float git_status<CR>")
