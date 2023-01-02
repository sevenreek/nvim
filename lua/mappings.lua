local function termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end

function tmap(shortcut, command)
  map('t', shortcut, command)
end

function xmap(shortcut, command)
  map('x', shortcut, command)
end
-- Easier split hopping
nmap("<C-h>", "<C-w> h")
nmap("<C-j>", "<C-w> j")
nmap("<C-k>", "<C-w> k")
nmap("<C-l>", "<C-w> l")
-- Faster ho highlight
nmap("<ESC>", "<cmd> noh <CR>")
-- Toggle relative numbers
nmap("<leader>rn", "<cmd> set rnu! <CR>")

-- Faster exit insert mode
imap("jj", "<ESC>")

-- Easier terminal exit
tmap("<C-x>", termcodes "<C-\\><C-N>")

-- Do not overrwrite register on paste
xmap("p", "p:let @+=@0<CR>:let @\"=@0<CR>")

-- nvim-tree
nmap("<leader>/", "<cmd> NvimTreeFocus <CR>")

-- Faster jk
nmap("J", "5j")
nmap("K", "5k")
