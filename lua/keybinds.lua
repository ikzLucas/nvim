local keybind = vim.keymap.set
-- map leader to space
vim.g.mapleader = " "

-- type Leader + ex or lex in normal to quickly open netrw
keybind("n", "<Leader>ex", "<Cmd>Ex %:p:h<CR>")
keybind("n", "<Leader>lex", "<Cmd>Lex %:p:h<CR>")
