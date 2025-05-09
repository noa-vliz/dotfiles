local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- 最新の安定版を使用
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- カーソル設定（グローバル設定）
vim.opt.cursorline = true -- カーソル行をハイライト
vim.opt.guicursor = "n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor/lCursor,r-cr-o:hor20-Cursor/lCursor"


-- プラグイン設定
require("lazy").setup({
  -- SpaceCampテーマ
  {
    "jaredgorski/SpaceCamp",
    priority = 1000, -- テーマは早く読み込まれるようにする
    config = function()
      -- テーマを適用
      vim.cmd([[colorscheme spacecamp]])
    end,
  },
  
  -- LSP関連
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- 補完プラグイン
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      
      -- スニペットエンジン
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      -- nvim-cmpの設定
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        }),
      })

      -- LSPの設定
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      
      -- LSPのアタッチ時の設定
      local on_attach = function(client, bufnr)
        local opts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, opts)
        
        -- 保存時に自動フォーマット（オプション）
        if client.server_capabilities.documentFormattingProvider then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function() vim.lsp.buf.format { async = false } end
          })
        end
      end
      
      -- Zigサーバーの設定
      local lspconfig = require('lspconfig')
      lspconfig.zls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
      }
    end
  },
})

-- Zigファイルを認識するための設定
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.zig",
  callback = function()
    vim.opt_local.filetype = "zig"
  end
})

