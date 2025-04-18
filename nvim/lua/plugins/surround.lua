return {
  {
    "kylechui/nvim-surround",
    version = "*", -- Используйте последнюю версию
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end
  },
}
