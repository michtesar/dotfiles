return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      transparent_background = true,
      show_end_of_buffer = false,
      integrations = {
        cmp = true,
        gitsigns = true,
        treesitter = true,
      },
    },
    config = function(_, opts)
      local theme = require("config.theme")

      require("catppuccin").setup(opts)
      theme.setup_command()
      theme.apply("system")

      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = theme.apply_transparency,
      })
    end,
  },
}
