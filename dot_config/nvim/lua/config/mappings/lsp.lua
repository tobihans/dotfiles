return {
  dart = {
    ["<Localleader>f"] = {
      name = " Flutter Tools",
      c = { function() require("telescope").extensions.flutter.commands() end, "Flutter Commands" },
      s = { function() require("telescope").extensions.flutter.fvm() end, "Flutter SDK (fvm)" },
    },
  },
  go = {
    ["<Localleader>g"] = {
      name = " Go Tools",
      c = { "<cmd>GoCmt<cr>", "Generate comment" },
      e = { function() vim.api.nvim_feedkeys(":GoGet ", "n", false) end, "Run go get" },
      f = { "<cmd>GoIfErr<cr>", "Generate if err" },
      g = { function() vim.api.nvim_feedkeys(":GoGenerate ", "n", false) end, "go generate" },
      i = { function() vim.api.nvim_feedkeys(":GoImpl ", "n", false) end, "Implement interace" },
      m = { function() vim.api.nvim_feedkeys(":GoMod ", "n", false) end, "Run go mod" },
      t = {
        name = "󰓹 Tags",
        a = { function() vim.api.nvim_feedkeys(":GoTagAdd ", "n", false) end, "Add yaml/json tag" },
        r = { function() vim.api.nvim_feedkeys(":GoTagRm ", "n", false) end, "Rm yaml/json tag" },
      },
      T = {
        name = "󰗇 Tests",
        a = { "<cmd>GoTestAdd<cr>", "Generate test" },
        e = { "<cmd>GoTestsExp<cr>", "Generate test for exported" },
        A = { "<cmd>GoTestsAll<cr>", "Generate test for all" },
      },
    },
  },
  rust = {
    ["<Localleader>r"] = {
      name = "󱘗 Rust Tools",
      x = { function() vim.cmd.RustLsp "expandMacro" end, " Expand Macros Recursively" },
      m = { function() vim.cmd.RustLsp "rebuildProcMacros" end, " Rebuild proc macros" },
      j = { function() vim.cmd.RustLsp "joinLines" end, " Join Lines" },
      c = { function() vim.cmd.RustLsp "openCargo" end, " Open Cargo.toml" },
      g = { function() vim.cmd.RustLsp "crateGraph" end, " View Crate Graph" },
      r = { function() vim.cmd.RustLsp { "runnables", "last" } end, " Runnables" },
      d = { function() vim.cmd.RustLsp { "debuggables", "last" } end, " Debuggables" },
      l = { function() vim.cmd.RustLsp "explainError" end, " Explain Error" },
      p = { function() vim.cmd.RustLsp "parentModule" end, " Go to parent module" },
      t = { function() vim.cmd.RustLsp "syntaxTree" end, " View syntax tree" },
      k = { function() vim.cmd.RustLsp "openDocs" end, " View syntax tree" },
    },
  },
  typst = {
    ["<Localleader>t"] = {
      name = "󰈦 Typst tools",
      w = { "<cmd>TypstWatch<cr>", "Watch and compile your document" },
      c = { "<cmd>Tocv<cr>", "Table of contents" },
    },
  },
  typescript = {
    ["<Localleader>t"] = {
      name = " Typescript tools",
      a = { function() vim.cmd.VtsExec "fix_all" end, " Fix all" },
      c = { function() vim.cmd.VtsExec "goto_project_config" end, " Open tsconfig.json" },
      d = { function() vim.cmd.VtsExec "goto_source_definition" end, " Source definition" },
      f = { function() vim.cmd.VtsExec "file_references" end, " File references" },
      i = { function() vim.cmd.VtsExec "add_missing_imports" end, " Add missing imports" },
      n = { function() vim.cmd.VtsExec "rename_file" end, " Rename file" },
      o = { function() vim.cmd.VtsExec "organize_imports" end, " Organize imports" },
      p = { function() vim.cmd.VtsExec "reload_projects" end, " Reload project" },
      r = { function() vim.cmd.VtsExec "restart_tsserver" end, " Restart underlying tsserver" },
      s = { function() vim.cmd.VtsExec "sort_imports" end, "Sort imports" },
      u = { function() vim.cmd.VtsExec "remove_unused_imports" end, " Remove unused imports" },
      v = { function() vim.cmd.VtsExec "select_ts_version" end, " Select ts version" },
      x = { function() vim.cmd.VtsExec "remove_unused" end, " Remove unused" },
    },
  },
}
