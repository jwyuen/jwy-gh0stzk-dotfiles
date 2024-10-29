-- local map = vim.keymap.set
vim.g.mapleader = ","
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>gd", builtin.lsp_definitions, { desc = "LSP go to definition" })
vim.keymap.set("n", "<leader>gt", builtin.lsp_type_definitions, { desc = "LSP go to type definition" })
vim.keymap.set("n", "<C-9>", "<cmd>bprev<CR>", { desc = "go to previous buffer" })
vim.keymap.set("n", "<C-0>", "<cmd>bnext<CR>", { desc = "go to next buffer" })
vim.keymap.set("n", "<leader>fd", function()
	MiniFiles.open()
end, { desc = "open mini.files (filetree)" })
