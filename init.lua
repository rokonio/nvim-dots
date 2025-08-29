local spec = {
  { "kylechui/nvim-surround", opts = true },
  { "m4xshen/autoclose.nvim", opts = { options = { pair_spaces = true } } },
  { "lukas-reineke/indent-blankline.nvim", opts = {}, main = "ibl" },
  { "ibhagwan/fzf-lua", opts = {} },
  { "folke/which-key.nvim", opts = {} },
  { "NMAC427/guess-indent.nvim", config = function() require('guess-indent').setup {} end },
  { "lewis6991/gitsigns.nvim", opts = {} },
  { "navarasu/onedark.nvim", config = function()
      require("onedark").setup({ style = "warmer" })
      require("onedark").load()
    end
  },
  { "derektata/lorem.nvim" },
  { "nvim-treesitter/nvim-treesitter-context", opts = { min_window_height = 1, separator = '-' } },
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

-- There is a bug where, if I configure netrw_liststyle=3 in the config
-- happens, but not when I switch to it by using i: when I press enter on a
-- folder right after opening netrw, I cd into this folder instead of
-- unfolding it, which leads to a second bug: when pressing - into this folder
-- that is now the only open, nvim crashes. 
-- I should probably submit a bug report, and a patch if I feel brave
vim.g.netrw_liststyle = 3
-- vim.cmd(":Vexplore") -- Use this to open the root directory (CWD)
-- vim.schedule(function() vim.cmd('silent! normal i') end)

vim.g.mapleader = " "
vim.keymap.set("n", "<space>", "<Nop>")
vim.keymap.set({"n", "x"}, "<Leader>y", "\"+y")
vim.keymap.set({"n", "x"}, "<Leader>Y", "<cmd>%y+<cr>")
vim.keymap.set({"n", "x"}, "<Leader>ff", "<cmd>FzfLua files<cr>")
vim.keymap.set({"n", "x"}, "<Leader>f", "<cmd>FzfLua<cr>")
vim.keymap.set({"n", "x"}, "j", "gj")
vim.keymap.set({"n", "x"}, "k", "gk")
vim.keymap.set({"n", "x", "i"}, "<C-C>", "<cmd>!start cmd '%'<cr>")

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
