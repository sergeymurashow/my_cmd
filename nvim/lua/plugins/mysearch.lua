local M = {}

function M.copy_all_matches()
  local search_pattern = vim.fn.getreg('/')
  if search_pattern == "" then
    vim.notify('No search pattern found.', vim.log.levels.WARN)
    return
  end

  local matches = {}
  local buf = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

  local regex = vim.regex(search_pattern)

  for lnum, line in ipairs(lines) do
    local start = 0
    while true do
      local s, e = regex:match_str(line:sub(start + 1))
      if not s then break end

      s = s + start
      e = e + start

      table.insert(matches, line:sub(s + 1, e + 1))
      start = e + 1
    end
  end

  if #matches == 0 then
    vim.notify('No matches found.', vim.log.levels.WARN)
    return
  end

  vim.fn.setreg('+', table.concat(matches, '\n'))
  vim.notify('Copied ' .. #matches .. ' matches to clipboard!', vim.log.levels.INFO)
end

return M
-- local M = {}
--
-- -- Собираем все позиции найденных вхождений и копируем
-- function M.copy_all_matches()
--   local search_pattern = vim.fn.getreg('/') -- получить последний паттерн поиска
--   if search_pattern == "" then
--     vim.notify('No search pattern found.', vim.log.levels.WARN)
--     return
--   end
--
--   local matches = {}
--   local current_pos = vim.fn.getpos('.')
--
--   -- Перейти в начало файла
--   vim.cmd('normal! gg')
--
--   -- Искать все совпадения
--   while true do
--     local found = vim.fn.search(search_pattern, 'W') -- 'W' чтобы не переходить в начало снова
--     if found == 0 then break end
--
--     -- получить строку в найденной позиции
--     local line = vim.fn.getline('.')
--
--     -- текущую позицию курсора
--     local col = vim.fn.col('.')
--     local matched = string.sub(line, col, col + #vim.fn.matchstr(line:sub(col), search_pattern) - 1)
--
--     if matched ~= "" then
--       table.insert(matches, matched)
--     end
--
--     -- сдвиг на 1 символ чтобы не зациклиться
--     vim.cmd('normal! l')
--   end
--
--   -- Вернуться обратно куда был курсор
--   vim.fn.setpos('.', current_pos)
--
--   if #matches == 0 then
--     vim.notify('No matches found.', vim.log.levels.WARN)
--     return
--   end
--
--   -- скопировать в системный буфер
--   vim.fn.setreg('+', table.concat(matches, '\n'))
--   vim.notify('Copied ' .. #matches .. ' matches to clipboard!', vim.log.levels.INFO)
-- end
--
-- return M
