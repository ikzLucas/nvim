local options = {
	-- line numbers
	number = true,
	relativenumber = true,
	-- three \t chars when pressing <tab>, replaced with whitespace
	tabstop = 3,
	shiftwidth = 3,
	expandtab = true,
}

-- For each option in options array, append vim.o to the option
for k, v in pairs (options) do
	vim.o[k] = v
end
