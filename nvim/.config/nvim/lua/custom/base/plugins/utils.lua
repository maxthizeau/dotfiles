return {
  {
    -- MAKE DOT OPERATOR WORK IN A SENSIBLE WAY
    "tpope/vim-repeat"
  }, {
  -- SWAPPABLE ARGUMENTS AND LIST ELEMENTS
  "mizlan/iswap.nvim",
  config = true
}, {
  -- BLOCK SORTER
  "chiedo/vim-sort-blocks-by"
}, {
  "junegunn/vim-easy-align",
  keys = {
    {
      "<leader>a",
      "<Plug>(EasyAlign)",
      desc = "Align for visual selection",
      mode = "x",
      noremap = true,
      silent = true
    }, {
    "<leader>a",
    "<Plug>(EasyAlign)",
    desc = "Align for motion/text object",
    mode = "n",
    noremap = true,
    silent = true
  }
  }
  ,
  {    -- DISPLAY HEX COLOURS
    "norcalli/nvim-colorizer.lua",
    config = function() require("colorizer").setup() end
  },
  {
    -- GENERATE HEX COLOURS
    "uga-rosa/ccc.nvim"
  },
  {
    -- ASYNC DISPATCH
    "tpope/vim-dispatch"
  }
} }
