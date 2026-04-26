return {
  "nvim-telescope/telescope.nvim",
  config       = function()
    local telescope = require "telescope"
    local builtin   = require "telescope.builtin"

    telescope.setup({
      pickers = {
        find_files = {
          find_command = {
            "fd",
            "--color", "never",
            "--exclude", ".git",
            "--follow",
            "--hidden",
            "--type", "file",
          },
        },
      },
    })

    telescope.load_extension("fzf")

    local mappings = {
      { lhs = "<leader>f/", rhs = builtin.current_buffer_fuzzy_find, desc = "Find in file" },
      { lhs = "<leader>fb", rhs = builtin.buffers,                   desc = "[f]ind [b]uffers" },
      { lhs = "<leader>ff", rhs = builtin.find_files,                desc = "[f]ind [f]ile" },
      { lhs = "<leader>fg", rhs = builtin.live_grep,                 desc = "[f]ile [g]rep" },
      { lhs = "<leader>fh", rhs = builtin.help_tags,                 desc = "[f]ind in [h]elp" },
      { lhs = "gr",         rhs = builtin.lsp_references,            desc = "List references" },
    }

    for _, mapping in ipairs(mappings) do
      vim.keymap.set("n", mapping.lhs, mapping.rhs, { desc = mapping.desc })
    end
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && " ..
          "cmake --build build --config Release --target install",
    },
  },
  event        = "VimEnter",
}
