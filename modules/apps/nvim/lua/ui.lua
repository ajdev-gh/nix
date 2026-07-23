local MiniSession = require("mini.sessions")
local MiniFiles = require("mini.files")
local MiniStarter = require("mini.starter")
local MiniPick = require("mini.pick")
local MiniPickPreview = require("mini-pick-preview")
local MiniExtra = require("mini.extra")
local MiniSnippets = require("mini.snippets")
local WhichKey = require("which-key")
local RenderMarkdown = require("render-markdown")

require("mini.icons").setup()

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

-- mini files ----
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

--- mini cmdline completion ---
require("mini.cmdline").setup()

--- mini surround ---
require("mini.surround").setup()
-- Default Keymaps
-- | `sa` | Add surrounding or Direct with 'saiw' |
-- | `sd` | Delete surrounding |
-- | `sr` | Replace surrounding |
-- | `sf` | Find surrounding (right) |
-- | `sF` | Find surrounding (left) |
-- | `sh` | Highlight surrounding |
-- | `sn` | Update n_lines |
-- | `l` / `n` | as suffix for prev/next |

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

--- mini snippets ---
MiniSnippets.setup({
  snippets = {
    MiniSnippets.gen_loader.from_lang(),     -- loads friendly-snippets
  },
})
MiniSnippets.start_lsp_server({ match = false })

--- which-key ---
WhichKey.setup({
  preset = "helix"
})

--- render-markdown ---
RenderMarkdown.setup()
