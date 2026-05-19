return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local status, configs = pcall(require, "nvim-treesitter.configs")
    if not status then
      return
    end

    configs.setup({
      -- ADD "python" HERE
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "query",
        "javascript",
        "typescript",
        "python",
        "c",
        "cpp",
        "markdown",
        "bash",
        "json",
        "xml"
      },

      sync_install = false,
      auto_install = true,
      indent = { enable = true },
      highlight = {
        enable = true,
        -- Setting this to true will run :h syntax and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
    })

    -- Templ config (Keep this as is, it looks correct)
    local treesitter_parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    treesitter_parser_config.templ = {
      install_info = {
        url = "https://github.com/vrischmann/tree-sitter-templ.git",
        files = { "src/parser.c", "src/scanner.c" },
        branch = "master",
      },
    }

    vim.treesitter.language.register("templ", "templ")
  end,
}
