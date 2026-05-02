local map = vim.keymap.set

for _, key in ipairs({ "<Up>", "<Down>", "<Left>", "<Right>" }) do
  map({ "n", "v", "i" }, key, "<Nop>", { desc = "Disable arrow keys" })
end

map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit window" })
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Recent files" })
map("n", "<leader>fp", "<cmd>Telescope projects<CR>", { desc = "Projects" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Find help" })
map("n", "<leader>fe", "<cmd>Telescope diagnostics<CR>", { desc = "Find diagnostics" })
map("n", "<leader>.", "<cmd>Telescope oldfiles<CR>", { desc = "Recent files (quick)" })

map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })

map("n", "<leader>n", "<cmd>Explore<CR>", { desc = "Open file explorer" })
map("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "LazyGit" })
map("n", "<leader>gd", "<cmd>LazyDocker<CR>", { desc = "LazyDocker" })
map("n", "<leader>db", "<cmd>DBUI<CR>", { desc = "Database UI" })
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Toggle diagnostics list" })
map("n", "<leader>xr", "<cmd>Trouble lsp_references toggle<CR>", { desc = "Toggle references list" })
map("n", "<leader>cg", "<cmd>Neogen<CR>", { desc = "Generate docstring/comments" })

map("n", "<leader>td", "<cmd>DiagnosticsToggle<CR>", { desc = "Toggle inline diagnostics" })
map("n", "<leader>tf", "<cmd>FormatOnSaveToggle<CR>", { desc = "Toggle format on save" })
map("n", "<leader>tz", "<cmd>FocusMode<CR>", { desc = "Focus mode on" })
map("n", "<leader>tZ", "<cmd>FocusModeOff<CR>", { desc = "Focus mode off" })

map("n", "<leader>ac", "<cmd>CodexToggle<CR>", { desc = "Toggle BeMind terminal (compat)" })
map("n", "<leader>ab", "<cmd>BeMindToggle<CR>", { desc = "Toggle BeMind terminal" })
map("n", "<leader>ao", "<cmd>OpenCodeToggle<CR>", { desc = "Toggle OpenCode terminal" })
