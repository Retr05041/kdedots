-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.termguicolors = true

vim.g.lazyvim_cmp = "nvim-cmp"

-- Set clipboard to use wl-copy and wl-paste for Wayland
if vim.fn.has("clipboard") == 1 then
  vim.o.clipboard = "unnamedplus"
  vim.g.clipboard = {
    name = "wl-clipboard",
    copy = {
      ["+"] = "wl-copy",
      ["*"] = "wl-copy",
    },
    paste = {
      ["+"] = "wl-paste",
      ["*"] = "wl-paste",
    },
  }
end
