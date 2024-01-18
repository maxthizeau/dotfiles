-- https://github.com/windwp/nvim-autopairs

local autopair = {
  'windwp/nvim-autopairs',
  event = "InsertEnter",
  -- opts = {} -- this is equalent to setup({}) function
  config = function()
    local status_ok, npairs = pcall(require, "nvim-autopairs")
    if not status_ok then
      return
    end

    npairs.setup {
      check_ts = true,
      ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        java = false,
      },
      disable_filetype = { "TelescopePrompt", "spectre_panel" },
      fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0, -- Offset from pattern match
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
      },
    }

    local cmp_autopairs = require "nvim-autopairs.completion.cmp"
    -- add nvim-ts-autotag to nvim-treesitter
    local cmp_status_ok, cmp = pcall(require, "cmp")
    if not cmp_status_ok then
      return
    end
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
  end
}

local autotag = {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "windwp/nvim-ts-autotag" },
    config = function()
      require("nvim-treesitter.configs").setup({
        autotag = {
          enable = true,
        },
      })
    end,
  } }


return {
  autopair,
  autotag
}
