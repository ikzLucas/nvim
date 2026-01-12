-- Lucas's neovim thingy - 2025-11-30
-- Requires neovim >=0.12.0 for native package manager and cmp stuff

local keybind = vim.keymap.set
-- map leader to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.diagnostic.config({ jump = { float = true } })
vim.g.netrw_liststyle = 3 -- netrw tree style by default
vim.g.have_nerd_font = true

-- Gentoo files fix
vim.opt.rtp:append("/usr/share/vim/vimfiles")

-- highlight text when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank({
			higroup = "Visual",
			timeout = 300,
		})
	end,
})

---- KEYBINDS ----
keybind("n", "<Leader>ex", "<Cmd>Ex %:p:h<CR>") -- Open netrw
keybind("n", "<Leader>lex", "<Cmd>Lex %:p:h<CR>") -- Split netrw left
keybind("n", "<Leader>rex", "<Cmd>Rex<CR>") -- Return to previous netrw window
keybind("n", "<Leader>vs", "<CMD>vs<CR>") -- Leader+vs vertical split - this is also <C-w>v
keybind("n", "<Leader>lf", vim.lsp.buf.format) -- LSP format code
keybind("n", "<Leader>d", vim.diagnostic.open_float) -- LSP diagnostic - this is also <C-w>d
keybind("n", "<Esc>", "<Cmd>nohlsearch<CR>") -- Clear highlights from search when pressing ESC
keybind("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
keybind("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
keybind("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
keybind("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
-- Options for neovim - see :help option-list
local options = {
	---- EDITOR OPTIONS ----
	confirm = true, -- confirm for actions like quit
	mouse = "a", -- mouse for resizing stuff

	---- APPEARANCE ----
	termguicolors = true,
	background = "light",
	signcolumn = "yes",
	splitright = true,
	splitbelow = true,

	-- LINE NUMBERS
	number = true,
	relativenumber = true,
	numberwidth = 2,
	scrolloff = 11,
	cursorline = true,

	---- SEARCH ----
	ignorecase = true,
	smartcase = true,

	---- TYPING ----
	tabstop = 3, -- three \t chars when pressing <tab>, replaced with whitespace
	shiftwidth = 3,
	expandtab = true,
   -- commented out, I'm using blink now
	-- autocomplete = true, -- enable 0.12.0 native autocompletions
	-- autocompletedelay = 50, -- slight delay before autocomplete begins
	inccommand = "split", -- preview subsitutions live
}

-- For each option in options array, append vim.o to the option
for k, v in pairs(options) do
	vim.o[k] = v
end

-- enable plugins and indentation for autodetected filetypes
vim.cmd.filetype("plugin indent on")

---- PLUGINS ----
vim.pack.add({
	{ src = "https://github.com/kylechui/nvim-surround" },
	{ src = "https://github.com/miikanissi/modus-themes.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
   { src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("*") },
})

require("nvim-surround").setup()
require("modus-themes").setup({
	style = "auto",
	variant = "tinted", -- `default`, `tinted`, `deuteranopia`, and `tritanopia`
	transparent = false,
	dim_inactive = true,
	hide_inactive_statusline = false,
	line_nr_column_background = true,
	sign_column_background = true,
	styles = {
		comments = { italic = true },
		keywords = { italic = true },
		functions = {},
		variables = {},
	},

	--- You can override specific color groups to use other groups or a hex color
	--- Function will be called with a ColorScheme table
	--- Refer to `extras/lua/modus_operandi.lua` or `extras/lua/modus_vivendi.lua` for the ColorScheme table
	---@param colors ColorScheme
	on_colors = function(colors) end,

	--- You can override specific highlights to use other groups or a hex color
	--- Function will be called with a Highlights and ColorScheme table
	--- Refer to `extras/lua/modus_operandi.lua` or `extras/lua/modus_vivendi.lua` for the Highlights and ColorScheme table
	---@param highlights Highlights
	---@param colors ColorScheme
	on_highlights = function(highlights, colors) end,
})
vim.cmd("colorscheme modus")

---- LSP ----

require("blink.cmp").setup({
   signature = { enabled = true },
})

-- filetypes
vim.filetype.add({
	pattern = {
		["%*ansible*.y*ml"] = "yaml.ansible",
		["%*docker-compose*.yml"] = "yaml.docker-compose",
		["docker-compose.yaml"] = "yaml.docker-compose",
		["compose.yml"] = "yaml.docker-compose",
		["compose.yaml"] = "yaml.docker-compose",
	},
})

require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"ansiblels",
		"clangd",
		"powershell_es",
		"docker_language_server",
		"docker_compose_language_service",
      "bashls",
	},
})
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
		},
	},
})
