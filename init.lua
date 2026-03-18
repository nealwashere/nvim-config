-- Load plugins
require('plugins')

-- Show matching brackets/parentheses
vim.o.showmatch = true

-- Highlight search results
vim.o.hlsearch = true

-- Show line numbers
vim.o.number = true

-- Command-line completion mode
vim.o.wildmode = "longest,list"

-- Enable syntax highlighting
vim.cmd('syntax on')

-- Enable mouse support
vim.o.mouse = 'a'

-- Use system clipboard
vim.o.clipboard = 'unnamedplus'

-- Fast terminal connection
vim.o.ttyfast = true

-- Highlight current line
vim.o.cursorline = true

-- GitHub theme setup
require('github-theme').setup({
    options = {
        styles = {
            comments = 'italic',
            conditionals = 'italic',
        },
    },
})

vim.cmd.colorscheme "github_dark_default"

-- Disable netrw (recommended by nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- Initialize web-devicons first
require('nvim-web-devicons').setup({
    -- Enable if you want default icons (with no plugins)
    default = true,
})

-- Initialize nvim-tree
require('nvim-tree').setup()

-- Optional: Add a keybinding to toggle nvim-tree
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { silent = true }) 

-- Initialize telescope
require('telescope').setup()

-- Telescope keymaps
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Initialize LSP Zero
local lsp_zero = require('lsp-zero')
lsp_zero.on_attach(function(client, bufnr)
    -- Define keybindings manually instead of using default_keybindings
    local opts = {buffer = bufnr}
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>vws', vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', '<leader>vca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>vrr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, opts)
    vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)
end)

-- Initialize Mason
require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = {
        'gopls',    -- Go language server
        'clangd',   -- C/C++ language server
        'pyright',  -- Python language server
        'ts_ls',    -- TypeScript/JavaScript language server
    },
    handlers = {
        lsp_zero.default_setup,
    }
})

-- Configure completion
local cmp = require('cmp')
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({select = false}),
        ['<C-Space>'] = cmp.mapping.complete(),
    })
})

-- Enable word wrap
vim.opt.wrap = true        -- Enable line wrapping
vim.opt.linebreak = true   -- Wrap lines at convenient points (words)
vim.opt.breakindent = true -- Preserve indentation in wrapped text

-- Tab keybindings
vim.keymap.set('n', '<C-t>', ':tabnew<CR>', { silent = true })
vim.keymap.set('n', '<C-w>', ':tabclose<CR>', { silent = true })