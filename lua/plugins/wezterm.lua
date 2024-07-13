-- -----------------------------------------------------------------------------
-- --------------------------------- WezTerm -----------------------------------
-- -----------------------------------------------------------------------------
return {
	"willothy/wezterm.nvim",
	config = true,
	cond = function() -- Using WezTerm
    local term = os.getenv("TERM_PROGRAM")
    return term and string.find(term, "WezTerm")
	end,
}
