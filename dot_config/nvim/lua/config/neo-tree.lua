local TRASH_CMD = vim.uv.os_uname().sysname == "Darwin" and { "trash", "-s" } or { "trash-put", "-f" }

return {
  sources = { "filesystem" },
  auto_clean_after_session_restore = true,
  close_if_last_window = true,
  ---@diagnostic disable-next-line: missing-fields
  source_selector = { winbar = false, statusline = false },
  commands = {
    system_open = function(state) vim.ui.open(state.tree:get_node():get_id()) end,
    parent_or_close = function(state)
      local node = state.tree:get_node()
      if node:has_children() and node:is_expanded() then
        state.commands.toggle_node(state)
      else
        require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
      end
    end,
    child_or_open = function(state)
      local node = state.tree:get_node()
      if node:has_children() then
        if not node:is_expanded() then
          state.commands.toggle_node(state)
        else
          if node.type == "file" then
            state.commands.open(state)
          else
            require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
          end
        end
      else
        state.commands.open(state)
      end
    end,
    find_files_in_dir = function(state)
      local node = state.tree:get_node()
      local path = node.type == "file" and node:get_parent_id() or node:get_id()
      Snacks.picker.files { cwd = path }
    end,
    find_all_files_in_dir = function(state)
      local node = state.tree:get_node()
      local path = node.type == "file" and node:get_parent_id() or node:get_id()
      Snacks.picker.files { cwd = path, hidden = true, ignored = true }
    end,
    find_words_in_dir = function(state)
      local node = state.tree:get_node()
      local path = node.type == "file" and node:get_parent_id() or node:get_id()
      Snacks.picker.grep { cwd = path }
    end,
    find_all_words_in_dir = function(state)
      local node = state.tree:get_node()
      local path = node.type == "file" and node:get_parent_id() or node:get_id()
      Snacks.picker.grep { cwd = path, hidden = true, ignored = true }
    end,
    copy_selector = function(state)
      local node = state.tree:get_node()
      local filepath = node:get_id()
      local filename = node.name
      local modify = vim.fn.fnamemodify
      local vals = {
        ["BASENAME"] = modify(filename, ":r"),
        ["EXTENSION"] = modify(filename, ":e"),
        ["FILENAME"] = filename,
        ["PATH (CWD)"] = modify(filepath, ":."),
        ["PATH (HOME)"] = modify(filepath, ":~"),
        ["PATH"] = filepath,
        ["URI"] = vim.uri_from_fname(filepath),
      }
      local options = vim.tbl_filter(function(val) return vals[val] ~= "" end, vim.tbl_keys(vals))
      if vim.tbl_isempty(options) then
        vim.notify("No values to copy", vim.log.levels.WARN)
        return
      end
      table.sort(options)
      vim.ui.select(options, {
        prompt = "Choose to copy to clipboard:",
        format_item = function(item) return ("%s: %s"):format(item, vals[item]) end,
      }, function(choice)
        local result = vals[choice]
        if result then
          vim.notify(("Copied: `%s`"):format(result))
          vim.fn.setreg("+", result)
        end
      end)
    end,
  },
  window = {
    width = 30,
    mappings = {
      ["<S-CR>"] = "system_open",
      O = "system_open",
      Y = "copy_selector",
      h = "parent_or_close",
      l = "child_or_open",
    },
    fuzzy_finder_mappings = {
      ["<C-J>"] = "move_cursor_down",
      ["<C-K>"] = "move_cursor_up",
    },
  },
  filesystem = {
    follow_current_file = { enabled = true },
    hijack_netrw_behavior = "open_current",
    use_libuv_file_watcher = vim.fn.has "win32" ~= 1,
    window = {
      mappings = {
        ["d"] = "trash",
        ["D"] = "delete",
        f = { "show_help", nowait = false, config = { title = "Find Files", prefix_key = "f" } },
        ["f/"] = "filter_on_submit",
        ff = "find_files_in_dir",
        fF = "find_all_files_in_dir",
        fw = vim.fn.executable "rg" == 1 and "find_words_in_dir" or nil,
        fW = vim.fn.executable "rg" == 1 and "find_all_words_in_dir" or nil,
      },
    },
    commands = {
      trash = function(state)
        local inputs = require "neo-tree.ui.inputs"
        local path = state.tree:get_node().path
        local msg = ("Are you sure you want to trash '%s'?"):format(path)
        inputs.confirm(msg, function(confirmed)
          if confirmed then
            vim.system({ unpack(TRASH_CMD), path }, {}):wait()
            require("neo-tree.sources.manager").refresh(state.name)
          end
        end)
      end,
      trash_visual = function(state, selected_nodes)
        local inputs = require "neo-tree.ui.inputs"
        local msg = ("Are you sure you want to trash %d items?"):format(#selected_nodes)
        inputs.confirm(msg, function(confirmed)
          if confirmed then
            local paths = vim.iter(selected_nodes):map(function(n) return n.path end):totable()
            vim.system({ unpack(TRASH_CMD), unpack(paths) }, {}):wait()
            require("neo-tree.sources.manager").refresh(state.name)
          end
        end)
      end,
    },
  },
  event_handlers = {
    {
      event = "neo_tree_buffer_enter",
      handler = function()
        vim.opt_local.statuscolumn = ""
        vim.opt_local.signcolumn = "auto"
        vim.opt_local.foldcolumn = "0"
      end,
    },
  },
}
