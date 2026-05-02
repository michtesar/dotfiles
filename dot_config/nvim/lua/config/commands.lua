local diagnostics_virtual_text_enabled = true
local format_on_save_enabled = true
local focus_mode_windows = {}
local diagnostics_before_focus = {}

local function diagnostics_current()
  return vim.diagnostic.config().virtual_text ~= false
end

local function diagnostics_enabled_for_buffer(bufnr)
  local ok, enabled = pcall(vim.diagnostic.is_enabled, { bufnr = bufnr })
  if ok then
    return enabled
  end
  return true
end

local function disable_diagnostics_for_buffer(bufnr)
  local ok = pcall(vim.diagnostic.enable, false, { bufnr = bufnr })
  if not ok then
    vim.diagnostic.disable(bufnr)
  end
end

local function enable_diagnostics_for_buffer(bufnr)
  local ok = pcall(vim.diagnostic.enable, true, { bufnr = bufnr })
  if not ok then
    vim.diagnostic.enable(bufnr)
  end
end

vim.api.nvim_create_user_command("DiagnosticsToggle", function()
  diagnostics_virtual_text_enabled = not diagnostics_virtual_text_enabled
  vim.diagnostic.config({ virtual_text = diagnostics_virtual_text_enabled })
  local state = diagnostics_virtual_text_enabled and "enabled" or "disabled"
  vim.notify("Inline diagnostics " .. state, vim.log.levels.INFO)
end, { desc = "Toggle inline diagnostics virtual text" })

vim.api.nvim_create_user_command("DiagnosticsOn", function()
  diagnostics_virtual_text_enabled = true
  vim.diagnostic.config({ virtual_text = true })
  vim.notify("Inline diagnostics enabled", vim.log.levels.INFO)
end, { desc = "Enable inline diagnostics virtual text" })

vim.api.nvim_create_user_command("DiagnosticsOff", function()
  diagnostics_virtual_text_enabled = false
  vim.diagnostic.config({ virtual_text = false })
  vim.notify("Inline diagnostics disabled", vim.log.levels.INFO)
end, { desc = "Disable inline diagnostics virtual text" })

vim.api.nvim_create_user_command("FormatOnSaveToggle", function()
  format_on_save_enabled = not format_on_save_enabled
  local state = format_on_save_enabled and "enabled" or "disabled"
  vim.notify("Format on save " .. state, vim.log.levels.INFO)
end, { desc = "Toggle format on save" })

vim.api.nvim_create_user_command("FormatOnSaveOn", function()
  format_on_save_enabled = true
  vim.notify("Format on save enabled", vim.log.levels.INFO)
end, { desc = "Enable format on save" })

vim.api.nvim_create_user_command("FormatOnSaveOff", function()
  format_on_save_enabled = false
  vim.notify("Format on save disabled", vim.log.levels.INFO)
end, { desc = "Disable format on save" })

vim.api.nvim_create_user_command("FocusMode", function()
  local winid = vim.api.nvim_get_current_win()
  local bufnr = vim.api.nvim_get_current_buf()
  if not focus_mode_windows[winid] then
    focus_mode_windows[winid] = {
      number = vim.wo.number,
      relativenumber = vim.wo.relativenumber,
      signcolumn = vim.wo.signcolumn,
      cursorline = vim.wo.cursorline,
    }
  end

  diagnostics_before_focus[winid] = diagnostics_enabled_for_buffer(bufnr)
  disable_diagnostics_for_buffer(bufnr)
  vim.wo.number = false
  vim.wo.relativenumber = false
  vim.wo.signcolumn = "no"
  vim.wo.cursorline = false
  vim.notify("Focus mode on", vim.log.levels.INFO)
end, { desc = "Minimal writing mode for current window" })

vim.api.nvim_create_user_command("FocusModeOff", function()
  local winid = vim.api.nvim_get_current_win()
  local bufnr = vim.api.nvim_get_current_buf()
  local previous = focus_mode_windows[winid]

  if diagnostics_before_focus[winid] then
    enable_diagnostics_for_buffer(bufnr)
  end
  diagnostics_before_focus[winid] = nil

  if previous then
    vim.wo.number = previous.number
    vim.wo.relativenumber = previous.relativenumber
    vim.wo.signcolumn = previous.signcolumn
    vim.wo.cursorline = previous.cursorline
    focus_mode_windows[winid] = nil
  else
    vim.wo.number = true
    vim.wo.relativenumber = true
    vim.wo.signcolumn = "yes"
    vim.wo.cursorline = true
  end
  vim.notify("Focus mode off", vim.log.levels.INFO)
end, { desc = "Disable writing mode for current window" })

_G.NvimIDE = {
  diagnostics_virtual_text_enabled = function()
    return diagnostics_virtual_text_enabled
  end,
  format_on_save_enabled = function()
    return format_on_save_enabled
  end,
}
