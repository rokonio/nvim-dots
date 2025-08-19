vim.pack.add({
    "https://github.com/kylechui/nvim-surround",
    -- "https://github.com/m4xshen/autoclose.nvim",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/lukas-reineke/indent-blankline.nvim",
    "https://github.com/NMAC427/guess-indent.nvim",
    "https://github.com/lewis6991/gitsigns.nvim"
})
require("nvim-surround").setup({})
require("nvim-treesitter.configs").setup({
    ensure_installed = {"typst"},
    highlight = {
        enable = true,
    },
})
require("ibl").setup({})
require("guess-indent").setup({})
require("gitsigns").setup({})
-- require("autoclose").setup({
--    keys = {
--       ["$"] = { escape = true, close = true, pair = "$$", enabled_filetypes = {"typst", "tex"} },
--    },
--    options = {
--        pair_spaces = true,
--    }
-- })
vim.opt.number = true
vim.opt.cursorline = true -- Highlight the current line
vim.g.mapleader = " "

vim.keymap.set("n", "<space>", "<Nop>")
vim.keymap.set("n", "<Leader>conf", "<cmd>tabnew $MYVIMRC<cr>")
vim.keymap.set("n", "<Leader>src", "<cmd>source $MYVIMRC<cr>")
vim.keymap.set({"n", "x"}, "<Leader>y", "\"+y")
vim.keymap.set({"n", "x"}, "<Leader>Y", "<cmd>%y+<cr>")
vim.keymap.set({"n", "x"}, "j", "gj")
vim.keymap.set({"n", "x"}, "k", "gk")

-- Highlight yanked text
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    pattern = '*',
    callback = function()
        vim.hl.on_yank({ timeout = 400 })
    end,
    group = highlight_group,
})

