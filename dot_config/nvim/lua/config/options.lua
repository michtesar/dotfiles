vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.termguicolors = true
vim.o.background = require("config.theme").detect_background()

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 250
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 8
vim.opt.showmode = false
vim.opt.laststatus = 3
vim.opt.confirm = true
vim.opt.timeoutlen = 300
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.inccommand = "split"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

if vim.fn.has("gui_running") == 1 then
  vim.opt.guifont = "JetBrainsMono Nerd Font:h14"
end
