require('telescope').setup { file_ignore_patterns = { 'node_modules' }, }

require('telescope').setup {
  defaults = vim.tbl_extend(
    "force",
    require('telescope.themes').get_ivy(),
    {
      sorting_strategy = "ascending",
      layout_config = {
        prompt_position = "top",
      },
      mappings = {
        i = {
          ['<C-k>'] = require('telescope.actions').move_selection_previous,
          ['<C-j>'] = require('telescope.actions').move_selection_next,
          ['<C-u>'] = require('telescope.actions').results_scrolling_up,
          ['<C-d>'] = require('telescope.actions').results_scrolling_down,
          ["<C-P>"] = require('telescope.actions').cycle_history_prev,
          ["<C-N>"] = require('telescope.actions').cycle_history_next,
          ["<C-Tab>"] = require('telescope.actions').toggle_selection,
          ["<C-S-Tab>"] = require('telescope.actions').toggle_selection,
        },
      },
    }
  ),
  pickers = {
    buffers = {
      path_display = { "smart", "shorten" },
      ignore_current_buffer = true,
      sort_lastused = true,
      mappings = {
        i = {
          ['<C-S-Tab>'] = require('telescope.actions').move_selection_previous,
          ['<C-Tab>'] = require('telescope.actions').move_selection_next,
        },
      },
    }
  },
}

require('nvim-treesitter.install').compilers = { 'clang' }
require('nvim-treesitter.configs').setup {
  highlight = { enable = true },
  ensure_installed = { 'html', 'typescript', 'javascript', 'json', 'http', 'vim', 'vimdoc', 'query', 'bash',
    'dockerfile', 'git_config', 'graphql', 'jsdoc', 'lua', 'regex', 'sql', 'terraform', 'yaml', 'c_sharp' },
}

for _, language in ipairs({ 'typescript', 'javascript' }) do
  require('dap').configurations[language] = {
    {
      type = 'pwa-node',
      request = 'attach',
      name = 'Attach',
      processId = require('dap.utils').pick_process,
      cwd = '${workspaceFolder}',
    }
  }
end

require('dapui').setup({
  force_buffers = true,
  layouts = { {
    elements = { {
      id = "scopes",
      size = 0.35
    }, {
      id = "breakpoints",
      size = 0.25
    }, {
      id = "stacks",
      size = 0.25
    }, {
      id = "watches",
      size = 0.15
    }
    },
    position = "left",
    size = 0.20
  }, {
    elements = { {
      id = "console",
      size = 0.50
    }, {
      id = "repl",
      size = 0.50
    } },
    position = "bottom",
    size = 10
  } },
});

require('dap-vscode-js').setup({
  debugger_path = 'c:/projects/vscode-js-debug', -- Path to vscode-js-debug installation.
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
})

require('dap.ext.vscode').type_to_filetypes = { ["pwa-node"] = { 'javascript', 'typescript' } }
require('telescope').load_extension('dap')
require('persistent-breakpoints').setup({ load_breakpoints_event = { "BufReadPost" } })

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

require('nvim-surround').setup({})

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


require("dressing").setup({})
require('Comment').setup({
  padding = true,
  sticky = true,
  ignore = nil,
  toggler = {
    line = ',gc',
    block = ',gb',
  },
  opleader = {
    line = ',tc',
    block = ',tb',
  },
  mappings = {
    basic = true,
    extra = true,
  },
})

require('treesj').setup({
  use_default_keymaps = false,
  max_join_length = 150,
});

local langs = require('treesj.langs')
langs.presets['javascript'].array.join.space_in_brackets = false
langs.presets['typescript'].array.join.space_in_brackets = false

require('neogen').setup({
  enabled = true,
  languages = {
    javascript = {
      template = {
        annotation_convention = "custom",
        custom = {
          { nil, "/** $1 */",       { no_results = true, type = { "func", "class" } } },
          { nil, "/** @type $1 */", { no_results = true, type = { "type" } } },
          { nil, "/** $1 */",       { type = { "class", "func", "type" } } },
        }
      }
    },
    typescript = {
      template = {
        annotation_convention = "custom",
        custom = {
          { nil, "/** $1 */",       { no_results = true, type = { "func", "class" } } },
          { nil, "/** @type $1 */", { no_results = true, type = { "type" } } },
          { nil, "/** $1 */",       { type = { "class", "func", "type" } } },
        }
      }
    }
  }
})

require("scrollbar").setup()

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
local function restore_nvim_tree()
  local api = require('nvim-tree.api')
  api.tree.change_root(vim.fn.getcwd())
  api.tree.open({ focus = false })
end

require('overseer').setup({
  task_list = {
    bindings = {
      ["?"] = "ShowHelp",
      ["g?"] = "ShowHelp",
      ["<CR>"] = "RunAction",
      ["<C-e>"] = "Edit",
      ["o"] = "Open",
      ["<C-v>"] = "OpenVsplit",
      ["<C-s>"] = "OpenSplit",
      ["<C-f>"] = "OpenFloat",
      ["<C-q>"] = "OpenQuickFix",
      ["p"] = "TogglePreview",
      ["<M-l>"] = "IncreaseDetail",
      ["<M-h>"] = "DecreaseDetail",
      ["L"] = "IncreaseAllDetail",
      ["H"] = "DecreaseAllDetail",
      ["<M-[>"] = "DecreaseWidth",
      ["<M-]>"] = "IncreaseWidth",
      ["{"] = "PrevTask",
      ["}"] = "NextTask",
      ["<M-k>"] = "ScrollOutputUp",
      ["<M-j>"] = "ScrollOutputDown",
    }
  },
  task_launcher = {
    bindings = {
      n = {
        ["<ESC>"] = "Cancel",
      }
    },
  },
  task_editor = {
    -- Set keymap to false to remove default behavior
    -- You can add custom keymaps here as well (anything vim.keymap.set accepts)
    bindings = {
      n = {
        ["<ESC>"] = "Cancel",
      },
    },
  },
})

local function get_cwd_as_name()
  local dir = vim.fn.getcwd(0)
  return dir:gsub("[^A-Za-z0-9]", "_")
end

require("auto-session").setup {
  auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/", "c:/projects/" },
  pre_save_cmds = {
    function()
      require('overseer').save_task_bundle(
        get_cwd_as_name(),
        -- Passing nil will use config.opts.save_task_opts. You can call list_tasks() explicitly and
        -- pass in the results if you want to save specific tasks.
        nil,
        { on_conflict = "overwrite" } -- Overwrite existing bundle, if any
      )
    end,
  },
  -- Optionally get rid of all previous tasks when restoring a session
  pre_restore_cmds = {
    function()
      for _, task in ipairs(require('overseer').list_tasks({})) do
        task:dispose(true)
      end
    end
  },
  post_restore_cmds = {
    function()
      require('overseer').load_task_bundle(get_cwd_as_name(), { ignore_missing = true })
    end,
    function()
      local api = require('nvim-tree.api')
      api.tree.change_root(vim.fn.getcwd())
      api.tree.open({ focus = false })
    end,
  },
}

require("telescope").load_extension("session-lens")
require('session-lens').setup({ theme = 'ivy', previewer = true })
require("dap.ext.vscode").json_decode = require("overseer.json").decode
require('duck').setup({ speed = 2 });
require('smoothcursor').setup({
  fancy = {
    enable = true,
    head = { cursor = "▷", texthl = "SmoothCursorGreen", linehl = nil },
    body = {
      { cursor = "", texthl = "SmoothCursorGreen" },
      { cursor = "●", texthl = "SmoothCursorAqua" },
      { cursor = "•", texthl = "SmoothCursorAqua" },
      { cursor = ".", texthl = "SmoothCursorBlue" },
    },
  },
  speed = 20,
  intervals = 8
})

-- require("neotest").setup({
--   consumers = {
--     overseer = require("neotest.consumers.overseer"),
--   },
--   adapters = {
--     require('neotest-jest')({
--       jestCommand = "npx jest",
--       jestConfigFile = function()
--         local file = vim.fn.expand('%:p')
--         if string.find(file, '\\src\\') then
--           return string.match(file, "(.-\\[^\\]+\\)src") .. "jest.config.ts"
--         end
--
--         return vim.fn.getcwd() .. '/jest.config.ts'
--       end,
--       env = { CI = true },
--     }),
--   }
--
-- })
-- require('coverage').setup()

