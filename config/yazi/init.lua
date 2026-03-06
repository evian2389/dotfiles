require("bunny"):setup({
  hops = {
    { key = "h", path = "~", desc = "Home" },
    { key = "d", path = "~/Downloads", desc = "Downloads" },
    { key = "c", path = "~/.config", desc = "Config" },
  },
})
