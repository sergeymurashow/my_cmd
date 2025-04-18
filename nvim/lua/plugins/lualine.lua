return {
  "nvim-lualine/lualine.nvim",
  optional = true,
  event = "VeryLazy",
  opts = function(_, opts)
    -- Создаём новую секцию lualine_x без старого Copilot компонента
    print("My lualine config")
    local new_lualine_x = {}
    for _, item in ipairs(opts.sections.lualine_x or {}) do
      -- Пропускаем элемент, если это старый Copilot компонент
      if not (type(item) == "table" and item.copilot) then
        table.insert(new_lualine_x, item)
      end
    end
    opts.sections.lualine_x = new_lualine_x

    -- Добавляем наш безопасный Copilot компонент
    table.insert(opts.sections.lualine_x, 2, {
      function()
        if not package.loaded["copilot"] then
          return ""
        end

        local ok, api = pcall(require, "copilot.api")
        if not ok or not api.status then
          return ""
        end

        local status = api.status()
        if not status or not status.data then
          return ""
        end

        local icon = "" -- Иконка Copilot
        local status_icon = status.data.status == "InProgress" and ""
          or status.data.status == "Warning" and ""
          or ""

        return icon .. status_icon
      end,
      color = { fg = "#6CC644" }, -- Цвет как в GitHub Copilot
      cond = function()
        return package.loaded["copilot"]
      end,
    })

    return opts
  end,
}
