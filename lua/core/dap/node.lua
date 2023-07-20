local DEBUGGER_PATH = vim.fn.stdpath("data") .. "/site/pack/packer/opt/vscode-js-debug"

local M = {}

function M.setup()
  require("dap-vscode-js").setup({
    node_path = "node",
    debugger_path = DEBUGGER_PATH,
    -- debugger_cmd = { "js-debug-adapter" },
    adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
  })

  for _, language in ipairs({ "typescript", "javascript" }) do
    require("dap").configurations[language] = {
      {
        name = "Launch file",
        type = "pwa-node",
        request = "launch",
        args = { "-r", "dotenv/config" },
        program = "${file}",
        rootPath = "${workspaceFolder}",
        cwd = "${workspaceFolder}",
        sourceMaps = true,
        skipFiles = { "<node_internals>/**" },
        console = "integratedTerminal",
      },
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch Current File (with dotenv)",
        cwd = vim.fn.getcwd(),
        runtimeArgs = { "-r", "dotenv/config" },
        runtimeExecutable = "node",
        args = { "${file}" },
        skipFiles = { "<node_internals>/**" },
      },
      {
        name = "Attach",
        type = "pwa-node",
        request = "attach",
        processId = require("dap.utils").pick_process,
        port = 3000,
        restart = true,
        rootPath = "${workspaceFolder}",
        cwd = "${workspaceFolder}",
      },
      {
        type = "pwa-node",
        request = "launch",
        name = "Debug Jest Tests",
        -- trace = true, -- include debugger info
        runtimeExecutable = "node",
        runtimeArgs = {
          "./node_modules/jest/bin/jest.js",
          "--runInBand",
        },
        rootPath = "${workspaceFolder}",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
      },
    }
  end
end

return M
