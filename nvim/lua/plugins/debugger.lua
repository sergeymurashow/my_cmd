return {
  {
    dir = vim.fn.stdpath("config") .. "/lua",
    name = "debugger",
    lazy = false,
    config = function()
      require("debugger").setup()
    end,
  },
}
