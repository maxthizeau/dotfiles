return {
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",

    dependencies = { "rafamadriz/friendly-snippets" },

    config = function()
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node

      require("luasnip.loaders.from_vscode").lazy_load()

      ls.filetype_extend("javascript", { "jsdoc" })
      ls.filetype_extend("scss", { "css" })
      ls.filetype_extend("typescriptreact", { "css" })
      ls.filetype_extend("javascriptreact", { "css" })

      ls.add_snippets("css", {
        -- display
        s("df",  t("display: flex;")),
        s("dg",  t("display: grid;")),
        s("db",  t("display: block;")),
        s("di",  t("display: inline;")),
        s("dib", t("display: inline-block;")),
        s("dn",  t("display: none;")),
        -- flexbox
        s("fdc", t("flex-direction: column;")),
        s("fdr", t("flex-direction: row;")),
        s("fww", t("flex-wrap: wrap;")),
        s("jcc", t("justify-content: center;")),
        s("jcsb", t("justify-content: space-between;")),
        s("jcsa", t("justify-content: space-around;")),
        s("jcfe", t("justify-content: flex-end;")),
        s("aic", t("align-items: center;")),
        s("aife", t("align-items: flex-end;")),
        -- position
        s("posa", t("position: absolute;")),
        s("posr", t("position: relative;")),
        s("posf", t("position: fixed;")),
        s("poss", t("position: sticky;")),
        -- overflow
        s("ovh", t("overflow: hidden;")),
        s("ova", t("overflow: auto;")),
        -- sizing
        s("w100", t("width: 100%;")),
        s("h100", t("height: 100%;")),
        s("wh100", { t({ "width: 100%;", "height: 100%;" }) }),
        -- text
        s("tac", t("text-align: center;")),
        s("tar", t("text-align: right;")),
        s("ttu", t("text-transform: uppercase;")),
        -- misc
        s("cur", t("cursor: pointer;")),
        s("usn", t("user-select: none;")),
        s("fz",  { t("font-size: "), i(1), t(";") }),
        s("lh",  { t("line-height: "), i(1), t(";") }),
        s("cr",  { t("border-radius: "), i(1), t(";") }),
        s("br",  { t("border-radius: "), i(1), t(";") }),
      })

      --- TODO: What is expand?
      vim.keymap.set({ "i" }, "<C-s>e", function()
        ls.expand()
      end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<C-s>;", function()
        ls.jump(1)
      end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<C-s>,", function()
        ls.jump(-1)
      end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<C-E>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, { silent = true })
    end,
  },
}
