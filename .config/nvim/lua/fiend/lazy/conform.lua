return {
  'stevearc/conform.nvim',
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = { "n", "v" },
      desc = "Format buffer or range",
    },
  },
  config = function()
     require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        rust = { "rustfmt", lsp_format = "fallback" },
        c = { "clang_format" },
        cpp = { "clang_format" },

        xml = { "xmlformat" },
        json = { "jq" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
      },

      formatters = {
        xmlformat = {
          command = "python3",
          args = { vim.fn.stdpath("config") .. "/scripts/xmlformat.py" },
          stdin = true,
        },
      },
    })
  end
}
