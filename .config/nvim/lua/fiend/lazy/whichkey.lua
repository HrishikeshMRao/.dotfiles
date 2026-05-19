return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    delay = 500,
    spec = {
      { "<leader>g",  group = "git" },
      { "<leader>gh", group = "git hunks (gitsigns)" },
      { "<leader>l",  group = "lsp" },
      { "<leader>s",  group = "search (telescope)" },
      { "<leader>o",  group = "obsidian" },
      { "<leader>h",  group = "harpoon" },
      { "<leader>d",  group = "debug (dap)" },
    },
  },
}
