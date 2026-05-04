return {
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    config = function()
      require("config.alpha").setup()
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        { "<leader>a", group = "AI/Agents" },
        { "<leader>d", group = "Database" },
        { "<leader>f", group = "Find" },
        { "<leader>g", group = "Git" },
        { "<leader>t", group = "Toggles" },
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "auto",
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "diagnostics", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#1e1e2e",
      timeout = 2000,
      stages = "fade_in_slide_out",
      render = "compact",
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      lsp = {
        progress = { enabled = false },
        hover = { enabled = true },
        signature = { enabled = true },
      },
      presets = {
        command_palette = true,
        long_message_to_split = true,
      },
    },
    config = function(_, opts)
      vim.notify = require("notify")
      require("noice").setup(opts)
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        sorting_strategy = "ascending",
        layout_config = {
          prompt_position = "top",
          preview_width = 0.55,
        },
        path_display = { "smart" },
        file_ignore_patterns = { "%.git/", "node_modules/", "__pycache__/" },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
      },
      extensions = {},
    },
    config = function(_, opts)
      local telescope = require("telescope")
      opts.extensions["ui-select"] = require("telescope.themes").get_dropdown({})
      telescope.setup(opts)
      telescope.load_extension("fzf")
      telescope.load_extension("ui-select")
    end,
  },
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      manual_mode = false,
      silent_chdir = true,
      detection_methods = { "lsp", "pattern" },
      patterns = {
        ".git",
        "Makefile",
        "package.json",
        "pyproject.toml",
        "Cargo.toml",
        "go.mod",
        "*.sln",
      },
      exclude_dirs = {
        "~/.cargo",
        "~/.local/share/nvim",
      },
    },
    config = function(_, opts)
      require("project_nvim").setup(opts)
      pcall(require("telescope").load_extension, "projects")
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {},
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "bash",
        "dockerfile",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "sql",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      local ok, ts_configs = pcall(require, "nvim-treesitter.configs")
      if ok then
        ts_configs.setup(opts)
        return
      end

      local fallback_ok, ts = pcall(require, "nvim-treesitter")
      if fallback_ok and type(ts.setup) == "function" then
        ts.setup(opts)
        return
      end

      vim.notify("nvim-treesitter is not ready; run :Lazy sync and restart Neovim", vim.log.levels.WARN)
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      direction = "float",
      float_opts = {
        border = "rounded",
      },
      size = 20,
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)

      local Terminal = require("toggleterm.terminal").Terminal
      local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
      local lazydocker = Terminal:new({ cmd = "lazydocker", hidden = true })
      local bmind = Terminal:new({ cmd = "bmind", hidden = true })
      local opencode = Terminal:new({ cmd = "opencode", hidden = true })

      vim.api.nvim_create_user_command("LazyGit", function()
        lazygit:toggle()
      end, { desc = "Toggle lazygit terminal" })

      vim.api.nvim_create_user_command("LazyDocker", function()
        lazydocker:toggle()
      end, { desc = "Toggle lazydocker terminal" })

      vim.api.nvim_create_user_command("BeMindToggle", function()
        bmind:toggle()
      end, { desc = "Toggle BeMind terminal" })

      vim.api.nvim_create_user_command("CodexToggle", function()
        bmind:toggle()
      end, { desc = "Toggle BeMind terminal (compat alias)" })

      vim.api.nvim_create_user_command("OpenCodeToggle", function()
        opencode:toggle()
      end, { desc = "Toggle OpenCode terminal" })
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      completions = { lsp = { enabled = true } },
    },
  },
  {
    "danymat/neogen",
    cmd = "Neogen",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      snippet_engine = "luasnip",
    },
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    dependencies = {
      "tpope/vim-dadbod",
      "kristijanhusak/vim-dadbod-completion",
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"
    end,
  },
}
