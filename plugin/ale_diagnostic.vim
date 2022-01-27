if has("nvim-0.6")
  augroup nvim_ale_diagnostic_events
    autocmd!
    autocmd User ALEWantResults lua require("ale_diagnostic").start_check()
    autocmd DiagnosticChanged * lua require("ale_diagnostic").notify_ale()
  augroup END
endif
