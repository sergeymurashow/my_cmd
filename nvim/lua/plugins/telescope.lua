return {
  -- Поиск
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fw", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
      vim.keymap.set("n", "<leader>gb", builtin.git_branches, {})
      vim.keymap.set("n", "<leader>gc", builtin.git_commits, {})
      vim.keymap.set("n", "<leader>gs", builtin.git_status, {})
      vim.keymap.set("n", "<leader>ls", builtin.lsp_document_symbols, {})
      vim.keymap.set("n", "gr", builtin.lsp_references, { noremap = true, silent = true })
      vim.keymap.set("n", "gd", builtin.lsp_definitions, { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>sm", function()
        vim.diagnostic.open_float(nil, { focusable = false })
      end, { noremap = true, silent = true, desc = "Show diagnostics for current line" })
    end,
  },
}
