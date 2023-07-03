
require('telescope').setup{ file_ignore_patterns = {'node_modules'}, }
require('nvim-treesitter.install').compilers = { 'clang' }

local actions = require('telescope.actions')
require('telescope').setup { 
    pickers = {
        find_files = { 
            mappings = { 
                i = { 
                    ['<C-k>'] = actions.move_selection_previous,
                    ['<C-j>'] = actions.move_selection_next,
                    ['<C-u>'] = actions.results_scrolling_up,
                    ['<C-d>'] = actions.results_scrolling_down,
                }, 
            }, 
        }, 
    },
}

require('nvim-treesitter.configs').setup {
    highlight = { enable = true },
    ensure_installed = { 'html', 'typescript', 'javascript', 'json', 'http', 'vim', 'vimdoc', 'query', 'bash', 'dockerfile', 'git_config', 'graphql', 'jsdoc', 'lua', 'regex', 'sql', 'terraform', 'yaml', 'c_sharp' },
}

require('dap').adapters['pwa-node'] = {
  type = 'server',
  host = 'localhost',
  port = '${port}',
  executable = {
    command = 'node',
    args = {'c:/projects/vscode-js-debug/out/src/dapDebugServer.js', '${port}'},
  }
}

require('dap').adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {'c:/users/rain/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js'},
}

require('dap').configurations.javascript = {
  {
    type = 'pwa-node',
    request = 'launch',
    name = 'Launch file',
    program = '${file}',
    cwd = '${workspaceFolder}',
  },
  {
    name = 'Launch',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
    name = 'Attach to process2',
    type = 'node2',
    request = 'attach',
    processId = require('dap.utils').pick_process,
  },
}

-- Debugger (VSCODE JS)
require('dap-vscode-js').setup({
  debugger_path = 'c:/projects/vscode-js-debug', -- Path to vscode-js-debug installation.
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
})

for _, language in ipairs({ 'typescript', 'javascript' }) do
  require('dap').configurations[language] = {
    {
      type = 'pwa-node',
      request = 'launch',
      name = 'Launch file',
      program = '${file}',
      cwd = '${workspaceFolder}',
    },
    {
      type = 'pwa-node',
      request = 'attach',
      name = 'Attach',
      processId = require('dap.utils').pick_process,
      cwd = '${workspaceFolder}',
    }
  }
end
require('dap').set_log_level('INFO')


local function attach()
  require('dap').run({
      name = 'test',
      type = 'pwa-node',
      request = 'attach',
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = 'inspector',
      outFiles = {'${workspaceRoot}/**/*.js'}, 
      skipFiles = {'<node_internals>/**/*.js'},
      })
end
local function attachToRemote()
  require('dap').run({
      name = 'test',
      type = 'pwa-node',
      request = 'attach',
      address = '127.0.0.1',
      port = 9229,
      localRoot = vim.fn.getcwd(),
      remoteRoot = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = 'inspector',
      --outFiles = {'${workspaceRoot}/**/*.js'}, 
      skipFiles = {'<node_internals>/**/*.js'},
  })
end

require('dap').defaults.fallback.terminal_win_cmd = '20split new'
vim.fn.sign_define('DapBreakpoint', {text = '🟥', texthl = '', linehl = '', numhl = ''})
vim.fn.sign_define('DapBreakpointRejected', {text = '🟦', texthl = '', linehl = '', numhl = ''})
vim.fn.sign_define('DapStopped', {text = '⭐️', texthl = '', linehl = '', numhl = ''})

vim.keymap.set('n', '<leader>dh', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<leader>dH', ':lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>')
vim.keymap.set({'n', 't'}, '<A-k>', function() require('dap').step_out() end)
vim.keymap.set({'n', 't'}, '<A-l>', function() require('dap').step_into() end)
vim.keymap.set({'n', 't'}, '<A-j>', function() require('dap').step_over() end)
vim.keymap.set({'n', 't'}, '<A-h>', function() require('dap').continue() end)
vim.keymap.set('n', '<leader>dn', function() require('dap').run_to_cursor() end)
vim.keymap.set('n', '<leader>dc', function() require('dap').terminate() end)
vim.keymap.set('n', '<leader>dR', function() require('dap').clear_breakpoints() end)
vim.keymap.set('n', '<leader>de', function() require('dap').set_exception_breakpoints({'all'}) end)
--vim.keymap.set('n', '<leader>da', function() attach() end)
vim.keymap.set('n', '<leader>da', function() attachToRemote() end)
vim.keymap.set('n', '<leader>di', function() require('dap.ui.widgets').hover() end)
vim.keymap.set('n', '<leader>d?', function()
    local widgets = require('dap.ui.widgets');
    widgets.centered_float(widgets.scopes)
end)
vim.keymap.set('n', '<leader>dk', ':lua require("dap").up()<CR>zz')
vim.keymap.set('n', '<leader>dj', ':lua require("dap").down()<CR>zz')
vim.keymap.set('n', '<leader>dr', ':lua require("dap").repl.toggle({}, "vsplit")<CR><C-w>l')
vim.keymap.set('n', '<leader>du', ':lua require("dapui").toggle()<CR>')

require('rest-nvim').setup({
  -- Open request results in a horizontal split
  result_split_horizontal = true,
  -- Keep the http file buffer above|left when split horizontal|vertical
  result_split_in_place = false,
  -- Skip SSL verification, useful for unknown certificates
  skip_ssl_verification = false,
  -- Encode URL before making request
  encode_url = true,
  result = {
    -- toggle showing URL, HTTP info, headers at top the of result window
    show_url = true,
    show_http_info = true,
    show_headers = true,
    -- executables or functions for formatting response body [optional]
    -- set them to false if you want to disable them
    formatters = {
      json = false,
      html = false,
    },
  },
  -- Jump to request line on run
  jump_to_request = false,
  env_file = '.env',
  custom_dynamic_variables = {},
  yank_dry_run = true,
})

vim.cmd('luafile ~/.nvimrc.nvimtree.lua')

require('nvim-surround').setup({ })
require('hlargs').setup({ performance = { slow_parse_delay = 5 } })

require('ccc').setup({
    -- Your preferred settings
    -- Example: enable highlighter
    highlighter = {
        auto_enable = true,
        lsp = true,
    },
})

local colors = {
  bg = '#101116',
  fg = '#F8F8F2',
  fgdark = '#D8D8D2',
  cursorline = '#303137',
  selection = '#44475A',
  comment = '#6272A4',
  red = '#FF5555',
  orange = '#FFB86C',
  yellow = '#F1FA8C',
  green = '#50fa7b',
  purple = '#BD93F9',
  cyan = '#8BE9FD',
  pink = '#FF79C6',
  bright_red = '#FF6E6E',
  bright_green = '#69FF94',
  bright_yellow = '#FFFFA5',
  bright_blue = '#D6ACFF',
  bright_magenta = '#FF92DF',
  bright_cyan = '#A4FFFF',
  bright_white = '#FFFFFF',
  menu = '#21222C',
  visual = '#3E4452',
  gutter_fg = '#4B5263',
  nontext = '#3B4048',
};

require('dracula').setup({
  colors = colors,
  overrides = {
    CursorLine = { bg = colors.cursorline },
    VertSplit = { fg = '#808080' },

    ['@variable.builtin'] = { fg = colors.orange },
    ['@property'] = { fg = colors.fgdark },

    NvimTreeRootFolder = { fg = colors.bg, bg = colors.yellow, bold = true, },
    NvimTreeCursorLine = { bg = colors.cursorline, },
    NvimTreeVertSplit = { fg = '#808080' },
    NvimTreeNormal = { bg = colors.bg },
    NvimTreeGitDirty = { fg = colors.orange, },
    NvimTreeGitNew = { fg = colors.green, },

    TelescopeSelection = { bg = colors.cursorline, },
    TelescopeMultiSelection = { bg = colors.cursorline, },
  },
})

require('nvim-treesitter.configs').setup({});

