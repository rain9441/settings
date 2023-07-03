-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    --{ 'dracula/vim', { 'as': 'dracula' } },
    { 'Mofiqul/dracula.nvim' },
    --{ 'dracula/vim', name = 'dracula' },
   
     -- Basics
    'nvim-tree/nvim-web-devicons',
    'ryanoasis/vim-devicons',
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    { 'nvim-treesitter/playground' },
    'jremmen/vim-ripgrep',
    --{'romgrk/barbar.nvim', init = function() vim.g.barbar_auto_setup = true end },
  --'nanozuki/tabby.nvim' ,

     -- Telescope
    'nvim-telescope/telescope.nvim',
    'nvim-lua/plenary.nvim',
   
     -- Git stuff
    'airblade/vim-gitgutter',     -- Show git diff of lines edited
    'tpope/vim-fugitive',         -- :Gblame
    'sindrets/diffview.nvim',
   
     -- Debugging
    'mfussenegger/nvim-dap',        -- Debugger
    'mxsdev/nvim-dap-vscode-js',    -- JS Debugger
   
     -- Flow -- eg tools to help in Vim
    { "uga-rosa/ccc.nvim" },
    { "kylechui/nvim-surround", event = "VeryLazy" },
    { 'm-demare/hlargs.nvim' },
    'RRethy/vim-illuminate',
    { 'vim-airline/vim-airline' },    -- Vim powerline
    --'preservim/nerdtree',
    { "nvim-tree/nvim-tree.lua", config = function() require("nvim-tree").setup {} end },
    { 'jlanzarotta/bufexplorer', branch = '7.4.24'},
    { 'neoclide/coc.nvim', branch = 'release' },
    'gennaro-tedesco/nvim-peekup', -- Interact with registers:
   
    'rest-nvim/rest.nvim',
     -- other
    --'scrooloose/syntastic',
    {
        'glepnir/dashboard-nvim',
        event = 'VimEnter',
        config = function() require('dashboard').setup { 
            theme = 'hyper',
            config = {
                disable_move = true,
                packages = { enable = false },
                project = {
                    enable = false,
                },
            }
        } end,
        dependencies = { {'nvim-tree/nvim-web-devicons'}}
    }
}, {
    performance = {
        rtp = {
            reset = false 
        }
    }
})

