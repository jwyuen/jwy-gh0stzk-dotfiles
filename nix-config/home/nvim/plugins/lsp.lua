local lspconfig = require("lspconfig")

require("lspconfig").bashls.setup({})
require("lspconfig").biome.setup({})
require("lspconfig").marksman.setup({})
require("lspconfig").nil_ls.setup({
	autostart = true,
	capabilities = caps,
	settings = {
		["nil"] = {
			nix = {
				autoEvalInputs = true,
			},
		},
	},
})
require("lspconfig").stylelint_lsp.setup({})
require("lspconfig").ts_ls.setup({})
require("lspconfig").yamlls.setup({})
