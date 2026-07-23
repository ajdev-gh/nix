local MiniSession = require("mini.sessions")
local MiniFiles = require("mini.files")
local MiniStarter = require("mini.starter")
local MiniStatus = require("mini.statusline")
local MiniPick = require("mini.pick")
local MiniPickPreview = require("mini-pick-preview")
local MiniExtra = require("mini.extra")
local WhichKey = require("which-key")
local RenderMarkdown = require("render-markdown")

vim.cmd.colorscheme("gruvbox")

require("mini.icons").setup()
require("mini.git").setup()
require("mini.diff").setup()

--- Session Manager ---
MiniSession.setup()

--- Starter Window ---
MiniStarter.setup({
  items = {
    {action = "MiniFiles.open()", name = "Open file tree", section = "Navigation"},
    {action = "lua vim.cmd('qa')", name = "Quit Neovim", section = "Navigation"},
    {section = MiniStarter.sections.recent_files(5,true)},
    {section = MiniStarter.sections.pick()},
  }
})

--- Status Line ---
MiniStatus.setup()

--- mini files ----
MiniFiles.setup({
  windows = {
    preview = true,
    width_preview = 80
  }
})

vim.keymap.set("n", "<leader>e", "<cmd>lua MiniFiles.open()<CR>", { desc = "Toggle mini file explorer" })
vim.keymap.set("n", "<leader>-", function()
  MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
  MiniFiles.reveal_cwd()
end, { desc = "Toggle into currently opened file" })

---- mini notify ----
require("mini.notify").setup({
  -- only show messages
  content = {
    format = function(notif)
      return notif.msg
    end,
  },
})

--- mini picker ---
MiniPick.setup()
MiniPickPreview.setup()
MiniExtra.setup()

vim.keymap.set("n", "<leader>ff", function() MiniPick.builtin.files() end, { desc = "Search files" })
vim.keymap.set("n", "<leader>fg", function() MiniPick.builtin.grep_live() end,
  { desc = "Search by word" })
vim.keymap.set("n", "<leader>fh", function() MiniPick.builtin.help() end, { desc = "Search Help" })

vim.keymap.set("n", "<leader>fx", function() MiniExtra.pickers.diagnostic() end, { desc = "Search diagnostics" })
vim.keymap.set("n", "<leader>fk", function() MiniExtra.pickers.keymaps() end, { desc = 'Search keymaps' })
vim.keymap.set("n", "<leader>fb", function() MiniExtra.pickers.buffers() end, { desc = 'Search Buffers' })

--- mini completions ---
require("mini.completion").setup({
  lsp_completion = {
    auto_setup = true,
  }
})

--- which-key ---
WhichKey.setup({
  preset = "helix"
})

--- render-markdown ---
RenderMarkdown.setup()
