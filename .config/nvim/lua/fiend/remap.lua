-- Set leader key to space
vim.g.mapleader = " "

-- Open file explorer (netrw) with <leader>pv
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move selected lines up or down in visual mode and re-indent
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")  -- Move selected lines down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")  -- Move selected lines upper

-- Join lines without losing cursor position
vim.keymap.set("n", "J", "mzJ`z")

-- Keep cursor in the middle of the screen when scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")  -- Scroll down
vim.keymap.set("n", "<C-u>", "<C-u>zz")  -- Scroll up

-- Center cursor after searching
vim.keymap.set("n", "n", "nzzzv")  -- Next search result
vim.keymap.set("n", "N", "Nzzzv")  -- Previous search result

-- Restart LSP server with <leader>zig
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

-- Paste over currently selected text without yanking it
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Copy to system clipboard in normal and visual mode
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Delete text without yanking it
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- Exit insert mode with <C-c> (Ctrl+C)
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Disable Q in normal mode
vim.keymap.set("n", "Q", "<nop>")

-- Open a new tmux session with <C-f> (Ctrl+f)
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Navigate through quickfix and location lists and center cursor
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")  -- Next item in quickfix list
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")  -- Previous item in quickfix list
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")  -- Next item in location list
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")  -- Previous item in location list

-- Find and replace all occurrences of the word under the cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make the current file executable with <leader>x
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Insert boilerplate code snippet with <leader>ee
vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>")

-- Edit Neovim configuration file with <leader>vpp
vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/fiend/lazy_init.lua<CR>")

-- Source the Neovim configuration file with <leader><leader>
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)


