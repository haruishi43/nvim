local setup, copilot = pcall(require, "copilot")
if not setup then
	return
end

copilot.setup({
	suggestion = {
		auto_trigger = false,
	},
	filetypes = {
		markdown = false,
	},
})

local cmp_setup, copilot_cmp = pcall(require, "copilot_cmp")
if not cmp_setup then
	return
end

copilot_cmp.setup({
	method = "getCompletionCycling",
})
