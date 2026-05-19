return {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre",
  opts = {
    signs = {
      add          = { text = "+" },
      change       = { text = "~" },
      delete       = { text = "_" },
      topdelete    = { text = "‾" },
      changedelete = { text = "~" },
      untracked    = { text = "┆" },
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      local opts = { buffer = bufnr, silent = true }

      vim.keymap.set("n", "]h", gs.next_hunk, vim.tbl_extend("force", opts, { desc = "Next git hunk" }))
      vim.keymap.set("n", "[h", gs.prev_hunk, vim.tbl_extend("force", opts, { desc = "Prev git hunk" }))
      vim.keymap.set("n", "<leader>ghs", gs.stage_hunk,                                    vim.tbl_extend("force", opts, { desc = "Stage hunk" }))
      vim.keymap.set("n", "<leader>ghr", gs.reset_hunk,                                    vim.tbl_extend("force", opts, { desc = "Reset hunk" }))
      vim.keymap.set("n", "<leader>ghb", function() gs.blame_line({ full = true }) end,    vim.tbl_extend("force", opts, { desc = "Blame line" }))
      vim.keymap.set("n", "<leader>ghd", gs.diffthis,                                      vim.tbl_extend("force", opts, { desc = "Diff this" }))
      vim.keymap.set("n", "<leader>ghp", gs.preview_hunk,                                  vim.tbl_extend("force", opts, { desc = "Preview hunk" }))
    end,
  },
}
