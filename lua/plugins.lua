lualine = require('lualine')
lualine.setup()

require("nvim-tree").setup({
  filters = { dotfiles = false, custom = { '^.git$' } },
  disable_netrw = true,
  open_on_setup = true,
  diagnostics = {
    enable = true
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 500
  }
})

-----------------
-- cmp Config: --
-----------------
local lspkind = require('lspkind')
local cmp = require('cmp')
cmp.setup({
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol',
      maxwidth = 50,
      elipsis_char = '...'
    })
  },
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  experimental = {
    ghost_text=true,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-----------------
-- LSP Config: --
-----------------
require("mason").setup()

require("mason-lspconfig").setup()
local signature_setup = {
  hint_prefix = "^ "
}

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  require('lsp_signature').on_attach(signature_setup, bufnr)

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', '<C-h>', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

require('lspconfig')['tsserver'].setup{
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities
}

require('lspconfig')['pyright'].setup{
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities
}

require('lspconfig')['pylsp'].setup{
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities
}

require('lspconfig')['svelte'].setup{
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities
}
-----------------
-- Treesitter Config: --
-----------------
local status, ts = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

ts.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  ensure_installed = {
    "typescript",
    "tsx",
    "javascript",
    "json",
    "yaml",
    "css",
    "html",
    "svelte",
    "python",
  },
  autotag = {
    enable = true,
  },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }

----------------------
-- Prettier Config: --
----------------------

local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.eslint.with({
      diagnostics_format = '[eslint] #{m}\n(#{c})'
    }),
    null_ls.builtins.diagnostics.fish
  }
})

local prettier = require("prettier")

prettier.setup({
  bin = 'prettier', -- or `'prettierd'` (v0.22+)
  filetypes = {
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "less",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
  },
})

-----------------------
-- Telescope Config: --
-----------------------
local telescope = require("telescope")
telescope.setup {
  defaults = {
    file_ignore_patterns = {
      "node_modules"
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
}
telescope.load_extension('fzf')
-----------------------
-- Autosessions Config: --
-----------------------
require("auto-session").setup {
  log_level = "error",
  cwd_change_handling = {
    post_cwd_changed_hook = function()
      lualine.refresh()
    end,
  },
}

require('tabline').setup({})
