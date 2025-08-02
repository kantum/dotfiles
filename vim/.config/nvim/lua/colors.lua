-- OneDarkPro setup
require("onedarkpro").setup({
  options = {
    transparency = true,
  },
})

-- Gruvbox setup
require("gruvbox").setup({
  overrides = {
    MatchParen = { bg = "none", fg = "#ff9900" },
    ColorColumn = { bg = "#ebdbb2" },
    Visual = { bg = "#ebdbb2" },
  },
  transparency = true,
})

--
-- detect macOS system appearance
local function is_dark_mode()
  local handle = io.popen('defaults read -g AppleInterfaceStyle 2>/dev/null')
  local result = handle:read("*a")
  handle:close()
  return result:match("Dark") ~= nil
end

-- apply theme manually
if is_dark_mode() then
  vim.cmd("set background=dark")
  vim.cmd("colorscheme onedark")
  vim.g.theme_id = 2
else
  vim.cmd("set background=light")
  vim.cmd("colorscheme gruvbox")
  vim.g.theme_id = 1
end
