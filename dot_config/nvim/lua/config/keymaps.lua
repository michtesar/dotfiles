local map = vim.keymap.set

local function lsp_action(method, fallback)
  return function()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if #clients == 0 then
      if fallback then
        return fallback()
      end
      vim.notify("No LSP client attached", vim.log.levels.WARN)
      return
    end

    local has_method = false
    for _, client in ipairs(clients) do
      if client.supports_method(method) then
        has_method = true
        break
      end
    end

    if not has_method then
      if fallback then
        return fallback()
      end
      vim.notify("No attached LSP supports " .. method, vim.log.levels.WARN)
      return
    end

    return fallback()
  end
end

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
map("n", "gd", lsp_action(vim.lsp.protocol.Methods.textDocument_definition, vim.lsp.buf.definition), { desc = "Go to definition" })
map("n", "gD", lsp_action(vim.lsp.protocol.Methods.textDocument_declaration, vim.lsp.buf.declaration), { desc = "Go to declaration" })
map("n", "gr", lsp_action(vim.lsp.protocol.Methods.textDocument_references, vim.lsp.buf.references), { desc = "Find references" })
map("n", "gi", lsp_action(vim.lsp.protocol.Methods.textDocument_implementation, vim.lsp.buf.implementation), { desc = "Go to implementation" })
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
