vim.pack.add({ "https://github.com/folke/lazy.nvim" })
require("lazy").setup({
  -- { "derektata/lorem.nvim" },
  { "lewis6991/gitsigns.nvim",                 opts = {} },
  { "ibhagwan/fzf-lua",                        opts = {} },
  { "folke/which-key.nvim",                    opts = {} },
  { "kylechui/nvim-surround",                  opts = {} },
  { "NMAC427/guess-indent.nvim",               opts = {} },
  { "lukas-reineke/indent-blankline.nvim",     opts = {}, main = "ibl" },
  { "m4xshen/autoclose.nvim",                  opts = { options = { pair_spaces = true } } },
  { "nvim-treesitter/nvim-treesitter-context", opts = { separator = '-' } },
  { "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "typst", "rust", "python", "c" },
      highlight = { enable = true },
    }
  },
  { "navarasu/onedark.nvim", config = function()
      require("onedark").setup({ style = "warmer" })
      require("onedark").load()
    end
  },

  -- LSP and more IDE like experience
  { "neovim/nvim-lspconfig" },
  { "mason-org/mason.nvim",           opts = {}, cmd = { "Mason", "MasonInstall" } },
  { "mason-org/mason-lspconfig.nvim", opts = {} },
  { "saghen/blink.cmp", version = "v1.6.0",
    event = "InsertEnter",
    opts = {
      keymap = { preset = "enter" },
      completion = {
        documentation = { auto_show = true },
        list = { selection = { preselect = false } }
      }, -- <c-space> doesn't work on windows
    },
  },
  { "nvim-mini/mini.basics", opts = { options = { win_border = "rounder" }, mappings = { basics = false } } },
  { "nvim-neo-tree/neo-tree.nvim", dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    opts = { enable_cursor_hijack = true },
  },

  -- Language specific plugins
  { "chomosuke/typst-preview.nvim", opts = { open_cmd = "start firefox -P typst-preview %s" } }
}, {
  performance = {
    cache = { enabled = true },
  }
})
vim.opt.ruler = true
vim.opt.scrolloff = 6
vim.opt.winheight = 21

vim.g.mapleader = " "
vim.keymap.set("n", "<space>", "<Nop>")
vim.keymap.set({ "n", "x" }, "<Leader>y", "\"+y")
vim.keymap.set({ "n", "x" }, "<Leader>h", ":e ~\\Documents\\myhelp.md<cr>")
vim.keymap.set({ "n", "x" }, "<Leader>Y", "<cmd>%y+<cr>")
vim.keymap.set({ "n", "x" }, "<Leader><Leader>", "<cmd>FzfLua files<cr>")
vim.keymap.set({ "n", "x" }, "j", "gj")
vim.keymap.set({ "n", "x" }, "k", "gk")
vim.keymap.set({ "n", "x", "i" }, "<C-C>", "<cmd>!start powershell<cr>")
vim.keymap.set({ "t", }, "<C-N>", "<C-\\><C-n>")
vim.keymap.set({ "t", }, "<C-w>", "<C-\\><C-n><C-w>")

-- TODO: Maybe put this in another file
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = {
        globals = { "vim", "requires" },
        disable = { 'missing-fields' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true)
      },
      telemetry = { enable = false }
    }
  }
})
