return {
  "folke/noice.nvim",
  opts = {
    notify = {
      enabled = true,
      view = "notify",
      opts = {
        top_down = false, -- Bottom to top
        render = "default",
        timeout = 3000,
        max_width = 50,
        max_height = 10,
      },
    },
    views = {
      notify = {
        backend = "notify",
        fallback = "mini",
        format = "notify",
        replace = false,
        merge = false,
      },
    },
  },
}
