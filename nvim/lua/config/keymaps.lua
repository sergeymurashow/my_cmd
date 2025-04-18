vim.keymap.set("n", "<C-s>", ":w<CR>", { silent = true })
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a", { silent = true })

vim.keymap.set("n", "<C-k>", ":m .-2<CR>==", { silent = true })
vim.keymap.set("n", "<C-j>", ":m .+1<CR>==", { silent = true })

vim.keymap.set("n", "<leader>db", ':lua require("dap").toggle_breakpoint()<CR>', { silent = true })
vim.keymap.set("n", "<leader>dc", ':lua require("dap").continue()<CR>', { silent = true })
vim.keymap.set("i", "C-x", "C-\\, C-n")
