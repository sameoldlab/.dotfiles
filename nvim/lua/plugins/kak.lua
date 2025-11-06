return {
  "kak.nvim",
  url = "https://codeberg.org/mirge/kak.nvim.git",
  --version = "^7", -- if you don't want breaking changes
  event = "VeryLazy", -- load after other plugins, to avoid conflicts
  opts = {
    -- your configuration here
  },
}
