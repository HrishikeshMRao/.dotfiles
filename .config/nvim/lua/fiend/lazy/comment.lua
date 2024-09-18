return {
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
      -- Map Ctrl+/ to comment toggle
      vim.keymap.set("n", "<C-_>", "<Plug>(comment_toggle_linewise_current)", { desc = "Toggle comment" })
      vim.keymap.set("x", "<C-_>", "<Plug>(comment_toggle_linewise_visual)", { desc = "Toggle comment" })
    end,
  },
}
