return {
  "tpope/vim-fugitive",
  config = function()
    -- Set up global keybindings for Fugitive commands
    vim.keymap.set("n", "<leader>g", vim.cmd.Git, { desc = "Git summary window" })
    vim.keymap.set("n", "<leader>ga", ":Git add .<CR>", { desc = "Git add all changes" })
    vim.keymap.set("n", "<leader>gc", ":Git commit -m<Space>", { desc = "Git commit with message" })
    vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", { desc = "Git blame" })
    vim.keymap.set("n", "<leader>gd", ":Git diff<CR>", { desc = "Git diff" })
    vim.keymap.set("n", "<leader>gl", ":Git log<CR>", { desc = "Git log" })
    vim.keymap.set("n", "<leader>gq", ":Git<CR>", { desc = "Git summary window" })
    vim.keymap.set("n", "<leader>gm", ":Git mergetool<CR>", { desc = "Git mergetool" })
    vim.keymap.set("n", "<leader>gt", ":Git difftool<CR>", { desc = "Git difftool" })
    vim.keymap.set("n", "<leader>gr", ":Git rebase -i<CR>", { desc = "Git interactive rebase" })

    -- Custom keybindings for Git pull and push
    vim.keymap.set("n", "<leader>gp", ":Git push<CR>", { desc = "Git push" })
    vim.keymap.set("n", "<leader>gpf", ":Git push --force<CR>", { desc = "Git push force" })
    vim.keymap.set("n", "<leader>gpo", ":Git push origin<CR>", { desc = "Git push to origin" })
    vim.keymap.set("n", "<leader>gP", ":Git pull<CR>", { desc = "Git pull" })
    vim.keymap.set("n", "<leader>gPr", ":Git pull --rebase<CR>", { desc = "Git pull with rebase" })
    vim.keymap.set("n", "<leader>gPo", ":Git pull origin<CR>", { desc = "Git pull from origin" })
    -- Set up an autocmd group for Fugitive buffers
    local fugitive = vim.api.nvim_create_augroup("fugitive", {})
    local autocmd = vim.api.nvim_create_autocmd

    autocmd("BufWinEnter", {
      group = fugitive,
      pattern = "*",
      callback = function()
        if vim.bo.ft ~= "fugitive" then
          return
        end

        -- Optionally, you can set buffer-specific keybindings or settings here
        -- For Fugitive buffers, additional configurations can be added if needed
      end,
    })
  end,
}
