-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Enforces a vertical bar cursor with blinking in Insert (i) and Command-line Insert (ci) modes
vim.opt.guicursor = "i-ci:ver25-blinkwait175-blinkon175-blinkoff150-Cursor/lCursor"
