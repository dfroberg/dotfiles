local fn = vim.fn
local cmd = vim.cmd
vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  _G.packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd [[packadd packer.nvim]] -- packadd packer module

require('packer').startup({
  function(use)
    use 'wbthomason/packer.nvim'
    use 'pearofducks/ansible-vim'
    use 'alker0/chezmoi.vim'
    use 'folke/tokyonight.nvim'
    use {
      'norcalli/nvim-colorizer.lua',
      config = function()
        require('colorizer').setup()
      end
    }
    use 'numToStr/FTerm.nvim'
    use 'stevearc/dressing.nvim'
    use {
      'windwp/nvim-ts-autotag',
      config = function()
        require('nvim-ts-autotag').setup()
      end
    }
    use {
      'ur4ltz/surround.nvim',
      config = function()
        require('surround').setup { mapping_style = 'sandwich' }
      end
    }
    use {
      'folke/trouble.nvim',
      config = function()
        require('trouble').setup()
      end
    }
    use {
      'lukas-reineke/indent-blankline.nvim',
      config = function()
        require('indent_blankline').setup()
      end
    }
    use {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup()
      end
    }
    use {
      'max397574/better-escape.nvim',
      config = function()
        require('better_escape').setup { mapping = { 'ii' }}
      end
    }
    use {
      'windwp/nvim-autopairs',
      config = function()
        require('configs._autopairs')
      end
    }

    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      config = function()
        require('configs._lualine')
      end
    }
    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = function()
        require('configs._treesitter')
      end
    }
    use {
      'ibhagwan/fzf-lua',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      config = function()
        require('configs._fzf-lua')
      end
    }
    use {
      'tamago324/lir.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
        'tamago324/lir-git-status.nvim',
        { 'kyazdani42/nvim-web-devicons', opt = true }
      },
      config = function ()
        require('configs._lir')
      end
    }
    use {
      'hrsh7th/nvim-cmp',
      requires = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'f3fora/cmp-spell',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        'onsails/lspkind-nvim',
        'rafamadriz/friendly-snippets',
        'neovim/nvim-lspconfig'
      },
      config = function()
        require('configs._nvim-cmp')
      end
    }
    use {
      'neovim/nvim-lspconfig',
      requires = {
        'b0o/schemastore.nvim',
        'williamboman/nvim-lsp-installer',
        'ray-x/lsp_signature.nvim'
      },
      config = function()
        require('configs._lspconfig')
      end
    }
    use {
      'jose-elias-alvarez/null-ls.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
        'neovim/nvim-lspconfig'
      },
      config = function()
        require('configs._null-ls')
      end
    }

    if packer_bootstrap then
      require('packer').sync()
    end
  end,
  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    }
  }
})

cmd [[
  augroup PackerSync
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup END
]]
