local options = {
   -- true color support
   termguicolors = true,
   -- ignore case in search
   ignorecase = true,
	-- line numbers
	number = true,
	relativenumber = true,
   numberwidth = 2,
	-- three \t chars when pressing <tab>, replaced with whitespace
	tabstop = 3,
	shiftwidth = 3,
	expandtab = true,
   -- scrolloff (lines always visible above/below cursor)
   scrolloff = 8,
}

-- For each option in options array, append vim.o to the option
for k, v in pairs (options) do
	vim.o[k] = v
end
