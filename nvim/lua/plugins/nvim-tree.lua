return {
  "nvim-tree/nvim-tree.lua",
  config = function()
    require("nvim-tree").setup({
      view = {
        float = {
          enable = true,
          open_win_config = {
            relative = "editor",
            width = math.floor(vim.o.columns * 0.7),
            height = math.floor(vim.o.columns * 0.8),
          }
        }
      },
      renderer = {
        full_name = true
      }
    })
  end
}
