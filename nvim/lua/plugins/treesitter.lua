return {
    {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    build = ":TSUpdate",
    config = function()
      require "configs.treesitter" -- Основной конфиг
      require("ts_context_commentstring").setup {
        enable_autocmd = false, -- Лучше отключить autocmd если используем treesitter integration
        -- Другие настройки модуля...
      }
    end,
  },
}
