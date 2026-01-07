-- LSP Inlay Hints - Type hints inline
table.insert(after_load, function()
	-- Enable inlay hints for supported LSP servers
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if client and client.server_capabilities.inlayHintProvider then
				-- Enable inlay hints by default
				vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
			end
		end,
	})

	-- Toggle inlay hints keymap
	vim.keymap.set("n", "<leader>th", function()
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		if vim.lsp.inlay_hint.is_enabled() then
			vim.notify("Inlay hints enabled")
		else
			vim.notify("Inlay hints disabled")
		end
	end, { desc = "Toggle Inlay Hints" })
end)
