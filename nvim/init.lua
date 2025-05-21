vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

-- vim.api.nvim_create_user_command("DapLaunch", function()
--   local dap = require("dap")
--
--   local ft = vim.bo.filetype
--   local cfg = dap.configurations[ft]
--
--   if not cfg then
--     vim.notify("🚨 Нет конфигурации для filetype: " .. ft, vim.log.levels.ERROR)
--     return
--   end
--
--   local adapter = dap.adapters["pwa-node"]
--   if type(adapter) ~= "function" then
--     vim.notify("❌ Адаптер pwa-node не инициализирован!", vim.log.levels.ERROR)
--     return
--   end
--
--   vim.notify("🚀 DAP стартует для " .. ft, vim.log.levels.INFO)
--   dap.continue()
-- end, { desc = "Safe DAP launch" })
