return {
  {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.5",

    dependencies = {
      "nvim-lua/plenary.nvim",
      "BurntSushi/ripgrep",
    },

    config = function()
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = require("telescope.actions").move_selection_next,
              ["<C-k>"] = require("telescope.actions").move_selection_previous,
            },
            n = {
              ["<C-j>"] = require("telescope.actions").move_selection_next,
              ["<C-k>"] = require("telescope.actions").move_selection_previous,
            },
          },
        },
      })
      require("telescope.health").check()
      -- Enable telescope fzf native, if installed
      pcall(require("telescope").load_extension, "fzf")

      -- See `:help telescope.builtin`
      vim.keymap.set(
        "n",
        "<leader>?",
        require("telescope.builtin").oldfiles,
        { desc = "[?] Find recently opened files" }
      )
      vim.keymap.set("n", "<leader>/", function()
        require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          previewer = true,
        }))
      end, { desc = "[/] Fuzzily search in current buffer]" })

      vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
      vim.keymap.set("n", "<leader>sg", require("telescope.builtin").git_files, {})
      vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
      vim.keymap.set("n", "<leader>sl", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
      vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
      vim.keymap.set("n", "<leader>sb", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
      vim.keymap.set("n", "<leader>sS", require("telescope.builtin").git_status, { desc = "" })
      vim.keymap.set("n", "<leader>sw", function()
        local word = vim.fn.expand("<cword>")
        require("telescope.builtin").grep_string({ search = word })
      end)
      vim.keymap.set("n", "<leader>sW", function()
        local Word = vim.fn.expand("<cWORD>")
        require("telescope.builtin").grep_string({ search = Word })
      end)
      vim.api.nvim_set_keymap(
        "n",
        "<Leader><tab>",
        "<Cmd>lua require('telescope.builtin').commands()<CR>",
        { noremap = false }
      )
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      -- This is your opts table
      -- This is your opts table
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      require("telescope").load_extension("ui-select")
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      require("telescope").load_extension("ui-select")
    end,
  },
}
