return {
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        debug = true,
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.diagnostics.pylint,
          --null_ls.builtins.formatting.clang_format,
          null_ls.builtins.diagnostics.markdownlint,
          null_ls.builtins.formatting.prettierd,
          --require("none-ls.diagnostics.cpplint"),
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort,
        },
      })
      vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, {})

      vim.diagnostic.config({
        -- update_in_insert = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })
    end,
  },
}
