return {
  {
    "bezhermoso/tree-sitter-ghostty",
    build = "make nvim_install",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build  = ":TSUpdate",
    config = function()
      local treesitter = require "nvim-treesitter"

      treesitter.setup()

      -- Supported. See https://github.com/nvim-treesitter/nvim-treesitter/blob/main/SUPPORTED_LANGUAGES.md.
      treesitter.install({
        "asm",
        "bash",
        "c",
        "comment",
        "cpp",
        "css",
        "csv",
        "diff",
        "fish",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "go",
        "gomod",
        "gosum",
        "gotmpl",
        "gowork",
        "html",
        "jq",
        "json",
        "llvm",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "mlir",
        "nginx",
        "objc",
        "objdump",
        "printf",
        "python",
        "rust",
        "sql",
        "swift",
        "toml",
        "vim",
        "vimdoc",
        "yaml",

        -- Third-party.
        "ghostty",
      })

      -- Highlighting.
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          -- Only if the filetype has an available parser.
          local lang = vim.treesitter.language.get_lang(args.match)
          if not vim.treesitter.language.add(lang) then
            return
          end

          vim.treesitter.start(args.buf, lang)

          -- Folds.
          vim.wo[0][0].foldexpr       = "v:lua.vim.treesitter.foldexpr()"
          vim.wo[0][0].foldmethod     = "expr"

          -- Indent.
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
        group = vim.api.nvim_create_augroup("treesitter.load", { clear = false }),
        pattern = { "*" },
      })
    end,
    lazy   = false,
  },
}
