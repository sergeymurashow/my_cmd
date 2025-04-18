return {
  {
    "rcarriga/nvim-notify",
    opts = {
      stages = "fade", -- Анимация появления/исчезновения
      timeout = 0, -- Время отображения уведомлений (в миллисекундах)
      max_width = 50, -- Максимальная ширина уведомлений
      max_height = 10, -- Максимальная высота уведомлений
      background_colour = "#000000", -- Цвет фона
      enabled = false, -- Отключить уведомления
    },
    config = function(_, opts)
      local notify = require("notify")
      notify.setup(opts)
      vim.notify = notify -- Заменить стандартную функцию уведомлений
    end,
  },
}
