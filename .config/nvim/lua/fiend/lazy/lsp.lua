return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ensure_installed = {
          "debugpy",
          "codelldb",
          "clang-format",
          "lua_ls",
          "pylsp",
          "pyright",
          "clangd",
          "rust_analyzer",
          "dockerls",
          "bashls",
          "marksman",
          "markdownlint",
          "mdformat",
          "markdown-oxide",
          "proselint",
          "prosemd_lsp",
          "prettier",
        },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({})
    end,
  },
  { "nvimdev/lspsaga.nvim" },
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      lspconfig.lua_ls.setup({ capabilities = capabilities })
      lspconfig.clangd.setup({ capabilities = capabilities })
      lspconfig.rust_analyzer.setup({ capabilities = capabilities })
      lspconfig.dockerls.setup({ capabilities = capabilities })
      lspconfig.bashls.setup({ capabilities = capabilities })
      lspconfig.pyright.setup({ capabilities = capabilities, filetypes = { "python" } })
      lspconfig.marksman.setup({ capabilities = capabilities, filetypes = { "markdown" } })
      lspconfig.prosemd_lsp.setup({ capabilities = capabilities, filetypes = { "markdown" } })
      lspconfig.markdown_oxide.setup({
        -- Ensure that dynamicRegistration is enabled! This allows the LS to take into account actions like the
        -- Create Unresolved File code action, resolving completions for unindexed code blocks, ...
        capabilities = vim.tbl_deep_extend("force", capabilities, {
          workspace = {
            didChangeWatchedFiles = {
              dynamicRegistration = true,
            },
          },
        }),
      })
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded", -- Adds a rounded border to the hover window
        max_width = 80, -- Sets the maximum width of the hover window
        max_height = 20, -- Sets the maximum height of the hover window
      })
      -- Highlighting configuration for LSP Hover
      vim.cmd([[highlight LspHover ctermfg=LightGray guifg=#dcdcdc]])

      local augroup = vim.api.nvim_create_augroup
      local autocmd = vim.api.nvim_create_autocmd
      local LSPGroup = augroup("LSPGroup", {})
      autocmd({ "BufWritePre" }, {
        group = LSPGroup,
        pattern = "*",
        command = [[%s/\s\+$//e]],
      })

      autocmd("LspAttach", {
        group = LSPGroup,
        callback = function(e)
          local opts = { buffer = e.buf }
          vim.keymap.set("n", "<leader>lD", function()
            vim.lsp.buf.declaration()
          end, opts)
          vim.keymap.set("n", "<leader>ld", function()
            vim.lsp.buf.definition()
          end, opts)
          vim.keymap.set("n", "<leader>lk", function()
            vim.lsp.buf.hover()
          end, opts)
          vim.keymap.set("n", "<leader>li", function()
            vim.lsp.buf.implementation()
          end, opts)
          vim.keymap.set("n", "<leader>lh", function()
            vim.lsp.buf.signature_help()
          end, opts)
          vim.keymap.set("n", "<leader>ca", function()
            vim.lsp.buf.code_action()
          end, opts)
          vim.keymap.set("n", "<leader>lf", function()
            vim.lsp.buf.add_workspace_folder()
          end, opts)
          vim.keymap.set("n", "<leader>lr", function()
            vim.lsp.buf.remove_workspace_folder()
          end, opts)
          vim.keymap.set("n", "<leader>ll", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set("n", "<leader>lt", function()
            vim.lsp.buf.type_definition()
          end, opts)
          vim.keymap.set("n", "<leader>ln", function()
            vim.lsp.buf.rename()
          end, opts)
          vim.keymap.set("n", "<leader>lR", function()
            vim.lsp.buf.references()
          end, opts)
          vim.keymap.set("n", "<leader>lo", function()
            vim.diagnostic.open_float()
          end, opts)
          vim.keymap.set("n", "[d", function()
            vim.diagnostic.goto_prev()
          end, opts)
          vim.keymap.set("n", "]d", function()
            vim.diagnostic.goto_next()
          end, opts)
          vim.keymap.set("n", "<leader>lq", function()
            vim.diagnostic.setloclist()
          end, opts)
        end,
      })
    end,
  },
}
