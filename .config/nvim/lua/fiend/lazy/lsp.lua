return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
          "clangd",
          "bashls",
          "marksman",
          "markdown_oxide",
        },
      })
    end,
  },
  {
    "paretje/nvim-man",
    config = function()
      local autocmd = vim.api.nvim_create_autocmd
      autocmd("User", {
        pattern = "ManOpen",
        callback = function()
          -- Close the man page with 'q'
          vim.keymap.set("n", "q", ":quit<CR>", { buffer = true, silent = true })

          -- Scroll down with 'j' and up with 'k'
          vim.keymap.set("n", "j", "<C-D>", { buffer = true })
          vim.keymap.set("n", "k", "<C-U>", { buffer = true })
        end,
      })
      vim.keymap.set("n", "<leader>k", ":Man <C-R><C-W><CR>", { noremap = true, silent = true })
      vim.g.nvim_man_default_target = "current"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      local lsps = {
        {
          "markdown_oxide",
          {
            -- Ensure that dynamicRegistration is enabled! This allows the LS to take into account actions like the
            -- Create Unresolved File code action, resolving completions for unindexed code blocks, ...
            capabilities = vim.tbl_deep_extend("force", capabilities, {
              workspace = {
                didChangeWatchedFiles = {
                  dynamicRegistration = true,
                },
              },
            }),
          },
        },
        { "marksman", { capabilities = capabilities, filetypes = { "markdown" } } },
        { "pyright", { capabilities = capabilities, filetypes = { "python" } } },
        { "lua_ls", { capabilities = capabilities } },
        { "bashls", { capabilities = capabilities } },
        {
          "clangd",
          {
            cmd = {
              "clangd",
              "--background-index",
              "--clang-tidy",
              "--header-insertion=iwyu",
              "--completion-style=detailed",
              "--function-arg-placeholders=1",
              "--fallback-style=llvm",
              "--log=error",
            },
            init_options = {
              fallbackFlags = { "-std=c++17" },
            },
            capabilities = capabilities,
          },
        },
      }

      for _, lsp in pairs(lsps) do
        local name, config = lsp[1], lsp[2]
        vim.lsp.enable(name)
        if config then
          vim.lsp.config(name, config)
        end
      end

      vim.lsp.config("*", {
        handlers = {
          ["textDocument/hover"] = function(err, result, ctx, config)
            return vim.lsp.handlers.hover(err, result, ctx, vim.tbl_extend("force", config or {}, {
              border = "rounded",
              max_width = 80,
              max_height = 20,
            }))
          end,
        },
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
            local origin_buf = vim.api.nvim_get_current_buf()
            local origin_pos = vim.api.nvim_win_get_cursor(0)

            local grp = vim.api.nvim_create_augroup("LspDefReturn", { clear = true })
            vim.api.nvim_create_autocmd("BufEnter", {
              group = grp,
              once = true,
              callback = function()
                local def_buf = vim.api.nvim_get_current_buf()
                vim.api.nvim_del_augroup_by_id(grp)
                if def_buf == origin_buf then return end
                vim.keymap.set("n", "q", function()
                  vim.api.nvim_set_current_buf(origin_buf)
                  vim.api.nvim_win_set_cursor(0, origin_pos)
                  pcall(vim.keymap.del, "n", "q", { buffer = def_buf })
                end, { buffer = def_buf, nowait = true, silent = true, desc = "Return to pre-definition location" })
              end,
            })

            vim.lsp.buf.definition()
          end, opts)
          vim.keymap.set("n", "K", function()
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
