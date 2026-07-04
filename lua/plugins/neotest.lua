return {
  "nvim-neotest/neotest",
  opts = function(_, opts)
    opts.adapters = opts.adapters or {}

    for i, adapter in ipairs(opts.adapters) do
      if type(adapter) == "function" then
        opts.adapters[i] = function()
          local built = adapter()
          if not built then return nil end

          -- Clear strict root checking so they register anywhere in the project
          if built.name == "neotest-go" or built.name == "neotest-golang" then
            built.recursive_run = true
            built.root = function(_) return vim.fn.getcwd() end
          elseif built.name == "neotest-python" then
            built.runner = "pytest"
            built.root = function(_) return vim.fn.getcwd() end
            built.is_test_file = function(file_path)
              if file_path:match "node_modules" or file_path:match ".venv" then return false end
              return file_path:match "test_.*%.py$" or file_path:match ".*_test%.py$"
            end
          end
          return built
        end
      end
    end
  end,
}
