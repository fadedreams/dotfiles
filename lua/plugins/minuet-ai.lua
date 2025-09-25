return {
	"milanglacier/minuet-ai.nvim",
	enabled = true,
	event = "BufReadPre",
	dependencies = { "nvim-lua/plenary.nvim" }, -- Required dependency
	opts = {
		provider = "openai_compatible",
		notify = "debug",
		n_completions = 1,
		add_single_line_entry = false,
		request_timeout = 5, -- Increased for reliability
		throttle = 1500, -- Avoid rate limits
		debounce = 600, -- Reduce API calls
		virtualtext = {
			auto_trigger_ft = { "lua" },
			keymap = {
				accept = "<Tab>",
				accept_line = "<A-a>",
				accept_n_lines = "<A-z>",
				prev = "<A-[>",
				next = "<A-]>",
				dismiss = "<A-e>",
			},
		},
		provider_options = {
			openai_compatible = {
				api_key = function()
					local file = io.open(vim.fn.expand("~/.config/openrouter.token"), "r")
					if file then
						local api_key = file:read("*all"):gsub("%s+", "")
						file:close()
						return api_key
					else
						vim.notify("Failed to read Openrouter API key", vim.log.levels.ERROR)
						return ""
					end
				end,
				end_point = "https://openrouter.ai/api/v1/chat/completions",
				model = "moonshotai/kimi-k2",
				-- model = "meta-llama/llama-4-maverick",
				-- model = "meta-llama/llama-3.1-8b-instruct",  -- Previous fallback
				name = "Openrouter",
				stream = true,
				optional = {
					max_tokens = 56,
					top_p = 0.9,
					provider = {
						sort = "throughput", -- Prioritize throughput for faster completion
					},
				},
			},
		},
	},
}
