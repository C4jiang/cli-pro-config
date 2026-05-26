vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- ========================================================================== --
--                                  SETTINGS                                  --
-- ========================================================================== --

local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.mouse = 'a'
opt.clipboard = 'unnamedplus'
opt.ignorecase = true
opt.smartcase = true
opt.termguicolors = true
opt.signcolumn = 'yes'
opt.updatetime = 250
opt.timeoutlen = 400
opt.splitright = true
opt.splitbelow = true
opt.scrolloff = 6
opt.sidescrolloff = 6
opt.wrap = false
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.undofile = true

-- ========================================================================== --
--                                  KEYMAPS                                   --
-- ========================================================================== --

vim.keymap.set('n', '<leader>w', '<cmd>w<cr>', { desc = 'Save file' })
vim.keymap.set('n', '<leader>q', '<cmd>q<cr>', { desc = 'Quit' })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<cr>')

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- ========================================================================== --
--                                   PLUGINS                                  --
-- ========================================================================== --

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ABSOLUTE SUPPRESSION OF ALL STARTUP NOISE
local function suppress(fn)
  local old_notify = vim.notify
  local old_print = print
  vim.notify = function() end
  print = function() end
  
  local ok, err = pcall(fn)
  
  vim.notify = old_notify
  print = old_print
  return ok, err
end

require('lazy').setup({
  -- Colorscheme
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      suppress(function()
        require('catppuccin').setup({ flavour = 'mocha' })
        vim.cmd.colorscheme 'catppuccin'
      end)
    end,
  },

  -- Icons
  { 'nvim-tree/nvim-web-devicons', lazy = true },

  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      suppress(function()
        require('lualine').setup({
          options = {
            theme = 'catppuccin',
            component_separators = '|',
            section_separators = '',
          },
        })
      end)
    end,
  },

  -- File Explorer
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    keys = {
      { '<leader>e', '<cmd>Neotree toggle<cr>', desc = 'Toggle Explorer' },
    },
  },

  -- Which Key
  { 'folke/which-key.nvim', event = 'VeryLazy', opts = {} },

  -- Fuzzy Finder
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find files' },
      { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Live grep' },
      { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Buffers' },
    },
  },

  -- Treesitter (Safety First for 0.12)
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      suppress(function()
        -- Try all known module locations
        local ts_configs = nil
        local ok, res = pcall(require, 'nvim-treesitter.configs')
        if ok then ts_configs = res else
          ok, res = pcall(require, 'nvim-treesitter')
          if ok then ts_configs = res end
        end

        if ts_configs and ts_configs.setup then
          ts_configs.setup({
            ensure_installed = { 'lua', 'python', 'markdown', 'json' },
            highlight = { enable = true },
            indent = { enable = true },
          })
        end
      end)
    end,
  },

  -- LSP (The main source of noise in 0.12)
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      suppress(function()
        local lspconfig = require('lspconfig')
        local mlsp = require('mason-lspconfig')
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        mlsp.setup({ ensure_installed = { 'lua_ls', 'pyright', 'ruff' } })

        local servers = { 'lua_ls', 'pyright', 'ruff' }
        for _, server in ipairs(servers) do
          if lspconfig[server] then
            lspconfig[server].setup({ capabilities = capabilities })
          end
        end

        vim.api.nvim_create_autocmd('LspAttach', {
          callback = function(ev)
            local map = function(lhs, rhs, desc)
              vim.keymap.set('n', lhs, rhs, { buffer = ev.buf, desc = desc })
            end
            map('gd', vim.lsp.buf.definition, 'Goto definition')
            map('gr', vim.lsp.buf.references, 'Goto references')
            map('K', vim.lsp.buf.hover, 'Hover')
          end,
        })
      end)
    end,
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = { 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip', 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-path' },
    config = function()
      suppress(function()
        local cmp = require('cmp')
        local luasnip = require('luasnip')
        cmp.setup({
          snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
          mapping = cmp.mapping.preset.insert({
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
          }),
          sources = { { name = 'nvim_lsp' }, { name = 'luasnip' }, { name = 'path' } },
        })
      end)
    end,
  },

  -- Git
  { 'lewis6991/gitsigns.nvim', opts = {} },
})

-- Final blow to startup messages
vim.opt.shortmess:append('AI')
