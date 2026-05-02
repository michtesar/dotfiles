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
