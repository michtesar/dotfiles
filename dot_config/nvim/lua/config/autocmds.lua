vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight yanked text",
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  desc = "Open launcher on empty startup",
  callback = function()
    if vim.fn.argc() ~= 0 then
      return
    end

    local empty_buffer = vim.fn.line("$") == 1 and vim.fn.getline(1) == ""
    if not empty_buffer then
      return
    end

    vim.schedule(function()
      pcall(vim.cmd, "Alpha")
    end)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  desc = "Use ergonomic explorer navigation",
  callback = function(event)
    local opts = { buffer = event.buf, silent = true, remap = true }

    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"

    vim.keymap.set("n", "h", "<Plug>NetrwTreeSqueeze", vim.tbl_extend("force", opts, { desc = "Explorer collapse directory" }))
    vim.keymap.set("n", "l", "<CR>", vim.tbl_extend("force", opts, { desc = "Explorer open item" }))
    vim.keymap.set("n", "<BS>", "-", vim.tbl_extend("force", opts, { desc = "Explorer parent directory" }))
    vim.keymap.set("n", "q", "<cmd>close<CR>", vim.tbl_extend("force", opts, { remap = false, desc = "Close explorer" }))
  end,
})
