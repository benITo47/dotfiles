vim.g.mapleader = " "
local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

map("n", "<leader>+", "<C-a>", { desc = "Increment number" })
map("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

map("n", "<leader>sv", "<C-w>v", { desc = "Split windows vertically" })
map("n", "<leader>sh", "<C-w>s", { desc = "Split windows horizontally" })
map("n", "<leader>se", "<C-w>=", { desc = "Make split equal" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close split" })

map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
map("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
map("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
map("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Go to next buffer" }) -- Go to next buffer
map("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Go to previous buffer" }) -- Go to previous buffer
map("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "Copy whole file" })
