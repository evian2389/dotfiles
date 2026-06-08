require("bunny"):setup({
  hops = {
    { key = "h", path = "~", desc = "Home" },
    { key = "d", path = "~/Downloads", desc = "Downloads" },
    { key = "c", path = "~/.config", desc = "Config" },
    { key = "w", path = "~/workspace", desc = "workspace" },
    { key = "6", path = "~/workspace/hmc6gen", desc = "hmc6gen" },
    { key = "u", path = "/run/media/jongho3/", desc = "usb" },
  },
  fuzzy_cmd = "fzf",
})
