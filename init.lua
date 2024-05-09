# vim:foldmethod=marker
--: Options {{{
vim.opt.foldmethod = 'marker'
--: }}}
--: Mappings {{{
--: Functions {{{
local function map(mode, prefix, suffix, rhs, opts)
	vim.keymap.set(mode, prefix .. suffix, rhs, opts)
end

local function nmap(prefix, suffix, rhs, opts)
	map('n', prefix, suffix, rhs, opts)
end

local function nmap_leader_with_desc(suffix, rhs, desc)
	nmap('<Leader>', suffix, rhs, { desc = desc })
end
--:}}}
map('i', '', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
map('i', '', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })
nmap_leader_with_desc('f', 'za<cr>', 'toggle [f]old')
nmap_leader_with_desc('i', vim.lsp.buf.hover, 'symbol [i]nfo')
nmap_leader_with_desc('gd', vim.lsp.buf.definition, '[g]o to [d]efinition')
nmap_leader_with_desc('gD', vim.lsp.buf.declaration, '[g]o to [D]eclaration')
nmap_leader_with_desc('ca', vim.lsp.buf.code_action, '[c]ode [a]ction')
--: }}}
--: Plugins {{{
--: Mini {{{
--: Bootstrap {{{
local path_package = vim.fn.stdpath('data') .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
	vim.cmd('echo "Installing `mini.nvim`" | redraw')
	local clone_cmd = {
		'git', 'clone', '--filter=blob:none',
		'https://github.com/echasnovski/mini.nvim', mini_path
	}
	vim.fn.system(clone_cmd)
	vim.cmd('packadd mini.nvim | helptags ALL')
end
--:}}}
--: mini.deps {{{
require('mini.deps').setup({ path = { package = path_package } })
--: }}}
--: mini.basics {{{
require('mini.basics').setup()
--: }}}
--: mini.clue {{{
local miniclue = require('mini.clue')
miniclue.setup({
	triggers = {
		-- Leader triggers
		{ mode = 'n', keys = '<Leader>' },
		{ mode = 'x', keys = '<Leader>' },

		-- Built-in completion
		{ mode = 'i', keys = '<C-x>' },

		-- `g` key
		{ mode = 'n', keys = 'g' },
		{ mode = 'x', keys = 'g' },

		-- Marks
		{ mode = 'n', keys = "'" },
		{ mode = 'n', keys = '`' },
		{ mode = 'x', keys = "'" },
		{ mode = 'x', keys = '`' },

		-- Registers
		{ mode = 'n', keys = '"' },
		{ mode = 'x', keys = '"' },
		{ mode = 'i', keys = '<C-r>' },
		{ mode = 'c', keys = '<C-r>' },

		-- Window commands
		{ mode = 'n', keys = '<C-w>' },

		-- `z` key
		{ mode = 'n', keys = 'z' },
		{ mode = 'x', keys = 'z' },
	},
	clues = {
		miniclue.gen_clues.builtin_completion(),
		miniclue.gen_clues.g(),
		miniclue.gen_clues.marks(),
		miniclue.gen_clues.registers(),
		miniclue.gen_clues.windows(),
		miniclue.gen_clues.z(),
		{ mode = 'n', keys = '<Leader>g', desc = '+go to' },
	},
	windows = {
		delay = 0,
	},
})
--:}}}
--: mini.comment {{{
require('mini.comment').setup()
--:}}}
--: mini.completion {{{
require('mini.completion').setup({
	delay = {
		completion = 250,
	},
})
--:}}}
--: mini.extra {{{
require('mini.extra').setup()
--:}}}
--: mini.files {{{
require('mini.files').setup()
--:}}}
--: mini.indentscope {{{
local mini_indentscope = require('mini.indentscope')

mini_indentscope.setup({
	draw = {
		delay = 50,
		animation = mini_indentscope.gen_animation.none(),
	},
})
--:}}}
--: mini.notify {{{
require('mini.notify').setup()
--:}}}
--: mini.pick {{{
require('mini.pick').setup()
--:}}}
--: mini.statusline {{{
require('mini.statusline').setup()
--:}}}
--: mini.tabline {{{
require('mini.tabline').setup()
--:}}}
--: mini.trailspace {{{
require('mini.trailspace').setup()
--:}}}
--:}}}
--: Melange {{{
MiniDeps.add('savq/melange-nvim')
vim.cmd.colorscheme('melange')
--:}}}
--: Fugitive {{{
MiniDeps.add('tpope/vim-fugitive')
--:}}}
--: TreeSitter {{{
MiniDeps.add('nvim-treesitter/nvim-treesitter')
require('nvim-treesitter.configs').setup({
	ensure_installed = { 'c', 'lua' },
	sync_install = false,
	auto_install = true,
	highlight = { enable = true },
	indent = { enable = true },
})
--:}}}
--: LSP Config {{{
MiniDeps.add('neovim/nvim-lspconfig')
local lspconfig = require('lspconfig')
lspconfig.clangd.setup({})
lspconfig.lua_ls.setup({})
--:}}}
--:}}}
