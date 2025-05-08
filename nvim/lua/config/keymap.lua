-- Добавляем копирование всех найденных на gy
-- vim.keymap.set('n', 'gy', function()
--   require('plugins.mysearch').copy_all_matches()
-- end, { noremap = true, silent = true })

-- Esc убирает подсветку как обычно
-- Можно настроить, если хочется автоматом:
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR><Esc>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a", { silent = true })

vim.keymap.set("n", "<C-k>", ":m .-2<CR>==", { silent = true })
vim.keymap.set("n", "<C-j>", ":m .+1<CR>==", { silent = true })

-- Не копировать в буфер при удалении строк
vim.keymap.set("n", "dd", '"_dd', { noremap = true })
vim.keymap.set("n", "D", '"_D', { noremap = true })

-- Для визуального режима тоже
vim.keymap.set("v", "d", '"_d', { noremap = true })
vim.keymap.set("v", "x", '"_x', { noremap = true })
vim.keymap.set("v", "X", '"_X', { noremap = true })
vim.keymap.set("v", "p", '"_dP', { noremap = true }) -- Не копировать при замене в визуальном режиме
--
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

-- -- Terminal
vim.keymap.set("n", "<leader>wtf", ":ToggleTerm direction=float<CR>")
vim.keymap.set("n", "<leader>wth", ":ToggleTerm direction=horizontal<CR>")
vim.keymap.set("n", "<leader>wtv", ":ToggleTerm direction=vertical size=40<CR>")

-- WhichKey ( Must be last! )
-- vim.keymap.set("n", "<leader>o", ":Neotree float git_status<CR>")
