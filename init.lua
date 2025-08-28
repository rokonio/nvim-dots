local spec = {
  { "kylechui/nvim-surround", opts = true },
  { "windwp/nvim-autopairs", opts = true },
  { "lukas-reineke/indent-blankline.nvim", opts = {}, main = "ibl" },
  { "ibhagwan/fzf-lua", opts = {} },
  { "folke/which-key.nvim", opts = {}},
  -- { "folke/snacks.nvim", opts = {
  --     -- indent = { enabled = true },
  --     picker = { enabled = true },
  --     bigfile = { enabled = true },
  --   }
  -- },
  { "NMAC427/guess-indent.nvim", config = function() require('guess-indent').setup {} end },
  { "lewis6991/gitsigns.nvim", opts = {} },
  { "navarasu/onedark.nvim", config = function()
      require("onedark").setup({ style = "warmer" })
      require("onedark").load()
    end
  },
  { "nvim-treesitter/nvim-treesitter", config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {"typst", "rust", "python", "c"},
        highlight = { enable = true }
      })
    end,
  },

  -- LSP and more IDE like experience
  { "neovim/nvim-lspconfig" },
  { "mason-org/mason.nvim", opts = {} },
  { "mason-org/mason-lspconfig.nvim", opts = {} },
  { "saghen/blink.cmp", version = "v1.6.0", opts = {
      keymap = { preset = "enter" },
      completion = {
        documentation = { auto_show = true },
        list = { selection = { preselect = false } }
      }, -- <c-space> doesn't work on windows
    }
  },
  -- Language specific plugins
  { "chomosuke/typst-preview.nvim", opts = { open_cmd = "start firefox -P typst-preview %s" } }
}
vim.pack.add({"https://github.com/folke/lazy.nvim"})
require("lazy").setup(spec)

vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.swapfile = false
vim.opt.winborder = "rounded"
vim.opt.scrolloff = 6
vim.g.netrw_winsize = 25
vim.g.netrw_banner = 0

vim.g.mapleader = " "
vim.keymap.set("n", "<space>", "<Nop>")
vim.keymap.set({"n", "x"}, "<Leader>y", "\"+y")
vim.keymap.set({"n", "x"}, "<Leader>Y", "<cmd>%y+<cr>")
vim.keymap.set({"n", "x"}, "j", "gj")
vim.keymap.set({"n", "x"}, "k", "gk")

-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  callback = function()
    vim.hl.on_yank({ timeout = 400 })
  end,
})

-- TODO: Maybe put this in another file ? 
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
