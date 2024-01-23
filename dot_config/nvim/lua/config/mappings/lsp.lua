-- luacheck: globals vim
return {
  dart = {
    ["<localleader>f"] = {
      name = " Flutter Tools",
      c = { function() require("telescope").extensions.flutter.commands() end, "Flutter Commands" },
      s = { function() require("telescope").extensions.flutter.fvm() end, "Flutter SDK (fvm)" },
    },
  },
  rust = {
    ["<localleader>r"] = {
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
    },
  },
  scala = {
    ["<localleader>s"] = {
      name = " Scala (Metals)",
      c = { function() require("telescope").extensions.metals.commands() end, "Metals Commands" },
    },
  },
}
