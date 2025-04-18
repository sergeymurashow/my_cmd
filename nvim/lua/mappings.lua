require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
 map("n", "<leader>qq", ":q!<CR>", { desc = "Force quit Neovim" })
map("n", "<leader>qs", ":wq<CR>", { desc = "Save and quit" })

map("n", "<C-j>", ":m .+1<CR>==", { desc = "Move line down", noremap = true, silent = true })
map("n", "<C-k>", ":m .-2<CR>==", { desc = "Move line up", noremap = true, silent = true })

-- Версия для визуального режима
map("v", "<ESC>j", ":m '>+1<CR>gv=gv", { desc = "Move selection down", noremap = true, silent = true})
map("v", "<ESC>k", ":m '<-2<CR>gv=gv", { desc = "Move selection up", noremap = true, silent = true })

-- Форматирование текущего буфера
-- map("n", "<leader>cf", function()
--   vim.lsp.buf.format({
--     async = true,
--     filter = function(client)
--       return client.name == "null-ls"
--     end
--   })
-- end, { desc = "Format file with null-ls" })

-- Показ доступных code actions
map("n", "<leader>cf", "<cmd>lua vim.lsp.buf.format()<CR>==", {desc="Format with null-ls"})
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
