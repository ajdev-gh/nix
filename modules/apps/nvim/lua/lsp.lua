vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format Local buffer" })
vim.keymap.set("n", "df", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

vim.diagnostic.config({ virtual_text = true })

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("mini.completion").get_lsp_capabilities())

vim.lsp.config("*", { capabilities = capabilities })

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
    },
  },
})

vim.lsp.config('nixd', {
  cmd = { 'nixd' },
  filetypes = { 'nix' },
  root_markers = { 'flake.nix', 'shell.nix', 'git' },
  settings = {
    nixd = {
      formatting = {
        command = { "alejandra" },
      },
    },
  },
})

vim.lsp.enable({
  "lua_ls",
  "basedpyright",
  "jdtls",
  "rust_analyzer",
  "nixd",
})

local MiniSnippets = require("mini.snippets")

--- mini cmdline completion ---
require("mini.cmdline").setup()

--- mini snippets ---
MiniSnippets.setup({
  snippets = {
    MiniSnippets.gen_loader.from_lang(),     -- loads friendly-snippets
  },
})
MiniSnippets.start_lsp_server({ match = false })
