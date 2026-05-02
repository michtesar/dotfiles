local M = {}

M.themes = {
  light = {
    background = "light",
    flavour = "latte",
    notify_background = "#eff1f5",
  },
  dark = {
    background = "dark",
    flavour = "mocha",
    notify_background = "#1e1e2e",
  },
}

function M.is_macos_dark_mode()
  local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
  if not handle then
    return false
  end

  local output = handle:read("*a") or ""
  handle:close()
  return output:match("Dark") ~= nil
end

function M.detect_background()
  return M.is_macos_dark_mode() and "dark" or "light"
end

function M.resolve_mode(mode)
  if mode == "light" or mode == "dark" then
    return mode
  end

  return M.detect_background()
end

function M.apply_transparency()
  -- Make Neovim surfaces transparent so Ghostty opacity/blur is visible everywhere.
  local groups = {
    "Normal",
    "NormalNC",
    "NormalFloat",
    "FloatBorder",
    "SignColumn",
    "FoldColumn",
    "LineNr",
    "CursorLineNr",
    "EndOfBuffer",
    "StatusLine",
    "StatusLineNC",
    "TabLineFill",
    "WinSeparator",
  }

  for _, group in ipairs(groups) do
    vim.api.nvim_set_hl(0, group, { bg = "none" })
  end
end

function M.apply(mode)
  local resolved_mode = M.resolve_mode(mode)
  local theme = M.themes[resolved_mode] or M.themes.dark

  vim.o.background = theme.background
  vim.g.catppuccin_flavour = theme.flavour
  vim.cmd.colorscheme("catppuccin")
  vim.g.theme_mode = resolved_mode

  vim.notify = require("notify")
  require("notify").setup({
    background_colour = theme.notify_background,
    timeout = 2000,
    stages = "fade_in_slide_out",
    render = "compact",
  })

  M.apply_transparency()
end

function M.setup_command()
  vim.api.nvim_create_user_command("Theme", function(opts)
    local arg = (opts.args or ""):lower()
    if arg == "" then
      M.apply("system")
      vim.notify("Theme: system", vim.log.levels.INFO)
      return
    end

    if arg == "system" or arg == "light" or arg == "dark" then
      M.apply(arg)
      vim.notify("Theme: " .. arg, vim.log.levels.INFO)
      return
    end

    vim.notify("Usage: :Theme [system|light|dark]", vim.log.levels.WARN)
  end, {
    desc = "Set Neovim theme",
    nargs = "?",
    complete = function()
      return { "system", "light", "dark" }
    end,
  })
end

return M
