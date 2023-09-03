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
    { 'Mofiqul/dracula.nvim' },

    -- Basics
    'nvim-tree/nvim-web-devicons',
    'ryanoasis/vim-devicons',
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    { 'nvim-treesitter/playground' },
    'jremmen/vim-ripgrep',
    --'tpope/vim-sleuth',

    -- Telescope
    'nvim-telescope/telescope.nvim',
    'nvim-lua/plenary.nvim',

    -- Pretty
    'stevearc/dressing.nvim',

    -- Git stuff
    'airblade/vim-gitgutter', -- Show git diff of lines edited
    'tpope/vim-fugitive',     -- :Gblame
    'sindrets/diffview.nvim',

    -- Debugging
    'mfussenegger/nvim-dap',     -- Debugger
    'mxsdev/nvim-dap-vscode-js', -- JS Debugger
    'rcarriga/nvim-dap-ui',
    'nvim-telescope/telescope-dap.nvim',
    'Weissle/persistent-breakpoints.nvim',

    -- Flow -- eg tools to help in Vim
    { 'uga-rosa/ccc.nvim' },
    { 'kylechui/nvim-surround', event = 'VeryLazy' },
    { 'm-demare/hlargs.nvim' },
    'RRethy/vim-illuminate',
    { 'vim-airline/vim-airline' }, -- Vim powerline
    { 'nvim-tree/nvim-tree.lua', config = function() require('nvim-tree').setup {} end },
    { 'jlanzarotta/bufexplorer', branch = '7.4.24' },
    { 'neoclide/coc.nvim',       branch = 'release' },
    'gennaro-tedesco/nvim-peekup', -- Interact with registers:
    'rest-nvim/rest.nvim',

    -- New stuff
    'numToStr/Comment.nvim',
    'kevinhwang91/nvim-bqf',
    'Wansmer/treesj',
    'danymat/neogen',
    'petertriho/nvim-scrollbar',
    -- 'nvim-neotest/neotest',
    -- 'nvim-neotest/neotest-jest',
    'rmagatti/auto-session',
    'rmagatti/session-lens',
    'stevearc/overseer.nvim',
    'tamton-aquib/duck.nvim',
    'gen740/SmoothCursor.nvim',
    'fedepujol/move.nvim',
    -- 'andythigpen/nvim-coverage',
}, {
    performance = {
        rtp = {
            reset = false
        }
    }
})

