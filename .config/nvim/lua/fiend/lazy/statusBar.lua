return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      sections = {
        lualine_x = {
          "lsp_status",
          "encoding",
          "fileformat",
          "filetype",
        },
      },
    })
  end,
}
