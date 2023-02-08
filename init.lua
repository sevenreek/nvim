--
-- Disable built-in plugins that are replaced by better functionality
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- INCLUDE OPTIONS
require "options"
-- INSTALL PACKER
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local install_plugins = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  print('Installing packer...')
  local packer_url = 'https://github.com/wbthomason/packer.nvim'
  vim.fn.system({'git', 'clone', '--depth', '1', packer_url, install_path})
  print('Done.')

  vim.cmd('packadd packer.nvim')
  install_plugins = true
end
-- PLUGINS
require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'

  -- Dependency used by other plugins
  use 'nvim-lua/plenary.nvim'

  -- Webicons used by plenty other plugins
  use 'nvim-tree/nvim-web-devicons'

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    }
  }
  -- lsp stuff

  use 'ray-x/lsp_signature.nvim'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  
  use "williamboman/mason.nvim" 
  use "williamboman/mason-lspconfig.nvim" 
  use 'neovim/nvim-lspconfig'
  -- completion icons
  use 'onsails/lspkind.nvim'
  -- vsnip
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  -- prettier
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'MunifTanjim/prettier.nvim'
  -- autotag
  use 'windwp/nvim-ts-autotag'
  --telescope
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
  -- sessions
  use 'rmagatti/auto-session'
  -- tabline
  use 'crispgm/nvim-tabline'
  -- indent lines
  use "lukas-reineke/indent-blankline.nvim"
  -- PACKER SYNC
  if install_plugins then
    require('packer').sync()
  end
end)

if install_plugins then
  return
end


require "plugins"

require "mappings"
