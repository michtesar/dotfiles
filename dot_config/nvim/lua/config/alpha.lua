local M = {}

local banner = {
  [[███╗   ███╗███████╗ ██████╗██╗  ██╗ █████╗ ███╗   ██╗██╗ ██████╗██╗     ███████╗███████╗]],
  [[████╗ ████║██╔════╝██╔════╝██║  ██║██╔══██╗████╗  ██║██║██╔════╝██║     ██╔════╝██╔════╝]],
  [[██╔████╔██║█████╗  ██║     ███████║███████║██╔██╗ ██║██║██║     ██║     █████╗  ███████╗]],
  [[██║╚██╔╝██║██╔══╝  ██║     ██╔══██║██╔══██║██║╚██╗██║██║██║     ██║     ██╔══╝  ╚════██║]],
  [[██║ ╚═╝ ██║███████╗╚██████╗██║  ██║██║  ██║██║ ╚████║██║╚██████╗███████╗███████╗███████║]],
  [[╚═╝     ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝ ╚═════╝╚══════╝╚══════╝╚══════╝]],
  [[]],
  [[        [ root@mechanicles ~/lab ]$ ./build_future --with-robots --no-mercy]],
  [[]],
  [[                 ╔══════════════════════════════════════╗]],
  [[                 ║   MECHANICLES // ROBOTIC MISCHIEF   ║]],
  [[                 ╚══════════════════════════════════════╝]],
  [[]],
  [[        ⚙️  code. metal. ghosts in machines.]],
}

function M.setup()
  local ok_dashboard, dashboard = pcall(require, "alpha.themes.dashboard")
  if not ok_dashboard then
    return
  end

  dashboard.section.header.opts.position = "center"
  dashboard.section.header.val = banner

  dashboard.section.buttons.opts.position = "center"
  dashboard.section.buttons.val = {
    dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
    dashboard.button("r", "  Recent files", ":Telescope oldfiles<CR>"),
    dashboard.button("g", "  Live grep", ":Telescope live_grep<CR>"),
    dashboard.button("c", "  Config", ":e ~/.config/nvim/init.lua<CR>"),
    dashboard.button("q", "󰩈  Quit", ":qa<CR>"),
  }

  dashboard.section.footer.opts.position = "center"
  dashboard.section.footer.val = {
    "Michael Tesar // dotfiles",
  }

  local content_height = #dashboard.section.header.val + #dashboard.section.buttons.val + #dashboard.section.footer.val + 4
  local top_padding = math.max(2, math.floor((vim.o.lines - content_height) / 2))

  dashboard.opts.layout = {
    { type = "padding", val = top_padding },
    dashboard.section.header,
    { type = "padding", val = 2 },
    dashboard.section.buttons,
    { type = "padding", val = 1 },
    dashboard.section.footer,
  }

  require("alpha").setup(dashboard.opts)
end

return M
