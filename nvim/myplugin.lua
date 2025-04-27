local M = {}

M.marks = {}

function M.add_mark()
    local pos = vim.api.nvim_win_get_cursor(0)
    local buf = vim.api.nvim_get_current_buf()
    table.insert(M.marks, { buf = buf, pos = pos })
    vim.notify "Закладка добавлена"
end

function M.jump_to_mark()
    if #M.marks == 0 then
        vim.notify "Нет закладок"
        return
    end
    local mark = table.remove(M.marks, 1)
    vim.api.nvim_set_current_buf(mark.buf)
    vim.api.nvim_win_set_cursor(0, mark.pos)
    vim.notify "Прыжок на закладку"
end

function M.show_marks()
    if #M.marks == 0 then
        vim.notify "Bookmarks is emmpty..."
        return
    end
    vim.ui.select(M.marks, {
        format_item = function(item)
            return item.pos
        end,
    }, function()
        vim.notify "test"
    end)
end
function M.show_telescope()
    local pickers = require "telescope.pickers"
    local finders = require "telescope.finders"
    local conf = require "telescope.config".values
    local my_data = { "Item 1", "Item 2", "Another item" }

    pickers.new({ initial_mode = "normal" }, {
        prompt_title = "My Custom Data",
        finder = finders.new_table {
            results = my_data,
        },
        sorter = conf.generic_sorter {},
    }):find()
end
function M.clear_marks()
    M.marks = {}
    vim.notify "Все закладки очищены"
end

function M.setup()
    -- vim.keymap.set("n", "<leader>m", M.add_mark, { desc = "Добавить закладку" })
    -- vim.keymap.set("n", "<leader>n", M.jump_to_mark, { desc = "Перейти к закладке" })
    -- vim.keymap.set("n", "<leader>-", M.show_marks, { desc = "Bookmarks" })
end

return M
