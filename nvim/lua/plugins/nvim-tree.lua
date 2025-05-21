return {
  "nvim-tree/nvim-tree.lua",
  opts = {
    on_attach = function(bufnr)
      local api = require("nvim-tree.api")
      local map = vim.keymap.set
      local opts = { noremap = true, silent = true, buffer = bufnr }

      -- Навигация и действия
      map("n", "l", api.node.open.edit, opts)
      map("n", "h", api.node.navigate.parent_close, opts)
      map("n", "<Backspace>", api.tree.change_root_to_parent, opts)
      map("n", ".", api.tree.change_root_to_node, opts)
      map("n", "d", api.fs.remove, opts)
      map("n", "a", api.fs.create, opts)
    end,
  },
}
