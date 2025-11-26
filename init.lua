-- Lucas's neovim thingy - 2025-11-26
-- Requires neovim >=0.12.0 for native package manager and cmp stuff
-- Fck it we monofile
-- Modules in ./lua/
-- require('options')
-- require('keybinds')

local keybind = vim.keymap.set
-- map leader to space
vim.g.mapleader = " "

-- type Leader + ex or lex in normal to quickly open netrw
keybind("n", "<Leader>ex", "<Cmd>Ex %:p:h<CR>")
keybind("n", "<Leader>lex", "<Cmd>Lex %:p:h<CR>")
-- Leader + so to update and reload config
keybind("n", "<Leader>so", "<CMD>update<CR> <CMD>source<CR>")
-- Leader keybind for write
keybind("n", "<Leader>w", "<CMD>write<CR>")

-- Options for neovim - see :help option-list
local options = {
---- APPEARANCE ----
    -- true color support
    termguicolors = true,
    -- background color
    background = "light",
	-- line numbers
	number = true,
	relativenumber = true,
    numberwidth = 2,
    -- scrolloff (lines always visible above/below cursor)
    scrolloff = 11,

---- SEARCH ----
    -- ignore case in search
    ignorecase = true,

---- TYPING ----
	-- four \t chars when pressing <tab>, replaced with whitespace
	tabstop = 4,
	shiftwidth = 4,
	expandtab = true,
    -- enable 0.12.0 native autocompletions
    autocomplete = true,
    autocompletedelay = 50,
}

-- For each option in options array, append vim.o to the option
for k, v in pairs (options) do
	vim.o[k] = v
end

-- enable plugins and indentation for autodetected filetypes
vim.cmd.filetype("plugin indent on")
