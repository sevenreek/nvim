-- COLORS
vim.opt.termguicolors = true
vim.cmd('colorscheme molokai')

-- LEADER
vim.g.mapleader = ' '

-- LINES AND COLUMNS
vim.opt.ru = false
vim.opt.number = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true -- highlight the line where cursor is
vim.opt.autoindent = true

-- INDENT 
vim.opt.tabstop = 4 -- each tab is 4 spaces
vim.opt.shiftwidth = 4 -- displays as 2
vim.opt.smartindent = true -- autoindent on special chars like {
--vim.opt.listchars = {tab = '| ', trail='•', nbsp='•'}
vim.opt.list = true

-- COMPLETION & HIGHLIGHT
vim.opt.completeopt={"preview", "menuone"} -- completion context menu
vim.opt.wildmenu = true


-- SEARCH CASE
vim.opt.ignorecase = true -- ignore case in / /s etc use \c to use case
vim.opt.smartcase = true -- use case if a capital letter is entered

-- RECOVERY
vim.opt.undofile = true -- save undo to a file
vim.opt.updatetime = 250 -- save swapfile after inactivity
vim.opt.history = 100 -- keep 100 commands in history

-- OTHER
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.timeoutlen = 500 -- timeout in mappings
vim.opt.ttyfast = true -- use fast tty connection
vim.opt.showcmd = true -- show partial command
vim.opt.title = true
vim.opt.hidden = true -- hide dirty buffers when a new one is opened
vim.opt.mouse="a"
vim.opt.clipboard="unnamedplus"
