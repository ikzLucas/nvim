-- Lucas's neovim thingy - 2025-11-30
-- Requires neovim >=0.12.0 for native package manager and cmp stuff

local keybind = vim.keymap.set
-- map leader to space
vim.g.mapleader = " "

vim.diagnostic.config({ jump = { float = true } })

---- KEYBINDS ----
keybind("n", "<Leader>ex", "<Cmd>Ex %:p:h<CR>")      -- open netrw
keybind("n", "<Leader>lex", "<Cmd>Lex %:p:h<CR>")    -- split netrw left
keybind("n", "<Leader>w", "<CMD>write<CR>")          -- Leader+w write
keybind("n", "<Leader>vs", "<CMD>vs<CR>")            -- Leader+vs vertical split
keybind("n", "<Leader>hs", "<CMD>hs<CR>")            -- Leader+hs horizontal split
keybind("n", "<Leader>lf", vim.lsp.buf.format)       -- LSP format code
keybind("n", "<Leader>d", vim.diagnostic.open_float) -- LSP diagnostic - this is also <C-w>d


-- temp
-- Leader + so to update and reload config
keybind("n", "<Leader>so", "<CMD>update<CR> <CMD>source<CR>")

-- Options for neovim - see :help option-list
local options = {
   ---- APPEARANCE ----
   termguicolors = true,
   background = "light",
   signcolumn = "yes",
   -- LINE NUMBERS
   number = true,
   relativenumber = true,
   numberwidth = 2,
   scrolloff = 11,

   ---- SEARCH ----
   ignorecase = true,

   ---- TYPING ----
   tabstop = 3, -- three \t chars when pressing <tab>, replaced with whitespace
   shiftwidth = 3,
   expandtab = true,
   autocomplete = true,    -- enable 0.12.0 native autocompletions
   autocompletedelay = 50, -- slight delay before autocomplete begins
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
})
vim.cmd("colorscheme modus")

---- LSP ----
require("mason").setup({
   ui = {
      icons = {
         package_installed = "✓",
         package_pending = "➜",
         package_uninstalled = "✗"
      }
   }
})
require("mason-lspconfig").setup {
   ensure_installed = { "lua_ls@3.15.0", "ansiblels", "clangd", "powershell_es" },
}
vim.lsp.config("lua_ls",
   {
      settings = {
         Lua = {
            workspace = {
               library = vim.api.nvim_get_runtime_file("", true),
            }
         }
      }
   }
)
