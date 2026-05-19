require("fiend.set")
require("fiend.remap")
require("fiend.lazy_init")

local augroup = vim.api.nvim_create_augroup
local indent_group = augroup("MarkdownIndent", { clear = true })

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

function R(name)
  require("plenary.reload").reload_module(name)
end

vim.filetype.add({
  extension = {
    templ = "templ",
  },
})

autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 40,
    })
  end,
})



autocmd("FileType", {
  pattern = "markdown",
  group = indent_group,
  command = "setlocal tabstop=2 shiftwidth=2 expandtab",
})

vim.g.loaded_perl_provider = 0
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

vim.opt.conceallevel = 1
vim.o.foldmethod = "syntax" -- Use syntax-based folding
vim.o.foldlevel = 99 -- Start with all folds open
