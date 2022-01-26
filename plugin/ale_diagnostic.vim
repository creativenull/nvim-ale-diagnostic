if has("nvim-0.6")
  augroup nvim_ale_diagnostic_events
    autocmd!
    autocmd DiagnosticChanged * lua require("ale_diagnostic").notify()
  augroup END
endif
