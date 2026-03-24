return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        -- hide only gitignored files by default
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
          hide_gitignored = true,
        },
      },
      commands = {
        copy_selector = function(state)
          -- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
          -- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
          local node = state.tree:get_node()
          local filepath = node:get_id()
          local filename = node.name
          local modify = vim.fn.fnamemodify

          local results = {
            filepath,
            modify(filepath, ":."),
            modify(filepath, ":~"),
            filename,
            modify(filename, ":r"),
            modify(filename, ":e"),
          }

          vim.ui.select({
            "1. Absolute path: " .. results[1],
            "2. Path relative to CWD: " .. results[2],
            "3. Path relative to HOME: " .. results[3],
            "4. Filename: " .. results[4],
            "5. Filename without extension: " .. results[5],
            "6. Extension of the filename: " .. results[6],
          }, { prompt = "Choose to copy to clipboard:" }, function(choice)
            if choice then
              local i = tonumber(choice:sub(1, 1))
              if i then
                local result = results[i]
                vim.fn.setreg("+", result)
                vim.notify("Copied: " .. result)
              else
                vim.notify("Invalid selection")
              end
            else
              vim.notify("Selection cancelled")
            end
          end)
        end,
        bazel_selector = function(state)
          local node = state.tree:get_node()
          local filepath = node:get_id()

          -- Determine starting directory
          local dir = filepath
          if vim.fn.isdirectory(filepath) == 0 then
            dir = vim.fn.fnamemodify(filepath, ":h")
          end

          -- Find BUILD.bazel file by walking up the directory tree
          local function find_build_file(start_dir)
            local cwd = vim.fn.getcwd()
            local current = start_dir
            while current ~= "/" and current ~= "" do
              local build_file = current .. "/BUILD.bazel"
              if vim.fn.filereadable(build_file) == 1 then
                return current
              end
              -- Stop if we've reached the CWD
              if current == cwd then
                break
              end
              current = vim.fn.fnamemodify(current, ":h")
            end
            return nil
          end

          local package_dir = find_build_file(dir)

          if not package_dir then
            vim.notify("No BUILD.bazel file found in parent directories", vim.log.levels.ERROR)
            return
          end

          -- Convert to Bazel package path (relative to workspace root)
          local relative_path = vim.fn.fnamemodify(package_dir, ":.")
          local bazel_package = "//" .. relative_path:gsub("^%./", "")

          -- Generate Bazel commands
          local results = {
            "bazel build " .. bazel_package .. ":all",
            "bazel test " .. bazel_package .. ":all",
            "bazel run //:gazelle -- update " .. relative_path:gsub("^%./", ""),
          }

          vim.ui.select({
            "1. Build: " .. results[1],
            "2. Test: " .. results[2],
            "3. Gazelle: " .. results[3],
          }, { prompt = "Choose Bazel command to copy:" }, function(choice)
            if choice then
              local i = tonumber(choice:sub(1, 1))
              if i then
                local result = results[i]
                vim.fn.setreg("+", result)
                vim.notify("Copied: " .. result)
              else
                vim.notify("Invalid selection")
              end
            else
              vim.notify("Selection cancelled")
            end
          end)
        end,
      },
      window = {
        mappings = {
          ["Y"] = "copy_selector",
          ["B"] = "bazel_selector",
        },
      },
    },
  },
}
