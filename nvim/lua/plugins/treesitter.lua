return {
   {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "typescript", "python", "bash", "json", "markdown", "html", "css", "yaml" },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true, -- Включить подсветку синтаксиса
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true }, -- Автоматическое выравнивание
        autotag = { enable = true }, -- Закрытие HTML/JSX тегов
      })
    end,
  },
  "nvim-treesitter/playground",
  cmd = "TSPlaygroundToggle",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("nvim-treesitter.configs").setup({
      playground = {
        enable = true,
        updatetime = 25, -- Время обновления в миллисекундах
        persist_queries = false,
      },
    })
  end,
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({ check_ts = true })
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
}
