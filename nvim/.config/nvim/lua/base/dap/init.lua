return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			defaults = {
				["<leader>x"] = { name = "+DAP" },
			},
		},
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{ "rcarriga/nvim-dap-ui" },
			{ "theHamsta/nvim-dap-virtual-text" },
		},
    -- stylua: ignore
    keys = {
      { "<leader>xR", function() require("dap").run_to_cursor() end,                               desc = "Run to Cursor", },
      { "<leader>xE", function() require("dapui").eval(vim.fn.input "[Expression] > ") end,        desc = "Evaluate Input", },
      { "<leader>xC", function() require("dap").set_breakpoint(vim.fn.input "[Condition] > ") end, desc = "Conditional Breakpoint", },
      { "<leader>xU", function() require("dapui").toggle() end,                                    desc = "Toggle UI", },
      { "<leader>xb", function() require("dap").step_back() end,                                   desc = "Step Back", },
      { "<leader>xc", function() require("dap").continue() end,                                    desc = "Continue", },
      { "<leader>xd", function() require("dap").disconnect() end,                                  desc = "Disconnect", },
      { "<leader>xe", function() require("dapui").eval() end,                                      mode = { "n", "v" },             desc = "Evaluate", },
      { "<leader>xg", function() require("dap").session() end,                                     desc = "Get Session", },
      { "<leader>xh", function() require("dap.ui.widgets").hover() end,                            desc = "Hover Variables", },
      { "<leader>xS", function() require("dap.ui.widgets").scopes() end,                           desc = "Scopes", },
      { "<leader>xi", function() require("dap").step_into() end,                                   desc = "Step Into", },
      { "<leader>xo", function() require("dap").step_over() end,                                   desc = "Step Over", },
      { "<leader>xp", function() require("dap").pause.toggle() end,                                desc = "Pause", },
      { "<leader>xq", function() require("dap").close() end,                                       desc = "Quit", },
      { "<leader>xr", function() require("dap").repl.toggle() end,                                 desc = "Toggle REPL", },
      { "<leader>xs", function() require("dap").continue() end,                                    desc = "Start", },
      { "<leader>xt", function() require("dap").toggle_breakpoint() end,                           desc = "Toggle Breakpoint", },
      { "<leader>xx", function() require("dap").terminate() end,                                   desc = "Terminate", },
      { "<leader>xu", function() require("dap").step_out() end,                                    desc = "Step Out", },
    },
		opts = {},
		config = function(plugin, opts)
			require("nvim-dap-virtual-text").setup({
				commented = true,
			})

			local dap, dapui = require("dap"), require("dapui")
			dapui.setup({})

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- set up debugger
			for k, _ in pairs(opts.setup) do
				opts.setup[k](plugin, opts)
			end
		end,
	},
}
