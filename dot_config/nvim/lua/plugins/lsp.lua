return {
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
    },
    opts = {
      ensure_installed = {
        "biome",
        "bashls",
        "cssls",
        "dockerls",
        "html",
        "jsonls",
        "lua_ls",
        "marksman",
        "rust_analyzer",
        "ruff",
        "taplo",
        "yamlls",
      },
    },
    config = function(_, opts)
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local has_new_lsp_api = vim.lsp and type(vim.lsp.config) == "table" and type(vim.lsp.enable) == "function"
      local lspconfig = has_new_lsp_api and nil or require("lspconfig")
      local ty_cmd = vim.fn.executable("uv") == 1 and { "uv", "run", "ty", "server" } or { "ty", "server" }

      require("mason-lspconfig").setup(opts)

      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = true,
        severity_sort = true,
        float = { border = "rounded", source = "if_many" },
      })

      local on_attach = function(_, bufnr)
        local map = function(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
        end

        map("K", vim.lsp.buf.hover, "Hover docs")
        map("<C-k>", vim.lsp.buf.signature_help, "Signature help")
        map("<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        map("<leader>f", function()
          require("conform").format({ async = true, lsp_fallback = true })
        end, "Format buffer")
      end

      local servers = {
        biome = {},
        bashls = {},
        cssls = {},
        dockerls = {},
        html = {},
        jsonls = {},
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
            },
          },
        },
        marksman = {},
        rust_analyzer = {},
        ruff = {},
        taplo = {},
        ts_ls = {},
        yamlls = {},
      }

      if has_new_lsp_api then
        vim.lsp.config("ty", {
          cmd = ty_cmd,
          settings = {
            ty = {},
          },
          capabilities = capabilities,
          on_attach = on_attach,
        })
        vim.lsp.enable("ty")
      else
        lspconfig.ty.setup({
          cmd = ty_cmd,
          settings = {
            ty = {},
          },
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end

      for server, server_opts in pairs(servers) do
        server_opts.capabilities = capabilities
        server_opts.on_attach = on_attach

        if has_new_lsp_api then
          vim.lsp.config(server, server_opts)
          vim.lsp.enable(server)
        else
          lspconfig[server].setup(server_opts)
        end
      end
    end,
  },
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      format_on_save = function(bufnr)
        if _G.NvimIDE and not _G.NvimIDE.format_on_save_enabled() then
          return nil
        end

        local disable_filetypes = {
          c = true,
          cpp = true,
        }

        return {
          timeout_ms = 1000,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        javascript = { "biome" },
        javascriptreact = { "biome" },
        json = { "biome" },
        jsonc = { "biome" },
        python = { "ruff_format" },
        toml = { "taplo" },
        typescript = { "biome" },
        typescriptreact = { "biome" },
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "onsails/lspkind.nvim",
      "saadparwaiz1/cmp_luasnip",
      "windwp/nvim-autopairs",
    },
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")

      require("nvim-autopairs").setup({})

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
          }),
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "buffer" },
        }),
      })

      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
}
