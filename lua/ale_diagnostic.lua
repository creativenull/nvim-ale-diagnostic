local M = {}

---NR code from diagnostic
---@param diagnostic table
---@return number
local function get_nr(diagnostic)
  if diagnostic.user_data and diagnostic.user_data.lsp and diagnostic.user_data.lsp.code then
    return diagnostic.user_data.lsp.code
  end

  return ''
end

---Filename from diagnostic
---@param diagnostic table
---@return string
local function get_filename(diagnostic)
  return vim.api.nvim_buf_get_name(diagnostic.bufnr)
end

---Severity Map
---@param diagnostic table
---@return string
local function get_severity_type(diagnostic)
  local ale_severity = {
    [vim.lsp.protocol.DiagnosticSeverity.Error] = 'E',
    [vim.lsp.protocol.DiagnosticSeverity.Warning] = 'W',
    [vim.lsp.protocol.DiagnosticSeverity.Information] = 'I',
    [vim.lsp.protocol.DiagnosticSeverity.Hint] = 'I',
  }

  return ale_severity[diagnostic.severity]
end

---Notify ALE on diagnostic change
---@return nil
function M.notify()
  local ale_diagnostics = {}
  local ale_source = 'nvim-lsp'
  local bufnr = vim.api.nvim_get_current_buf()
  local diagnostics = vim.diagnostic.get()

  if not vim.tbl_isempty(diagnostics) then
    for _, diagnostic in pairs(vim.diagnostic.get()) do
      -- Ensure it's the same buffer and not other buffers
      if diagnostic.bufnr == bufnr then
        table.insert(ale_diagnostics, {
          ['text'] = diagnostic.message,
          ['lnum'] = diagnostic.lnum + 1, -- offset correction
          ['col'] = diagnostic.col + 1,   -- offset correction
          ['end_col'] = diagnostic.end_col,
          ['end_lnum'] = diagnostic.end_lnum,
          ['bufnr'] = diagnostic.bufnr,
          ['filename'] = get_filename(diagnostic),
          ['vcol'] = 0,
          ['type'] = get_severity_type(diagnostic),
          ['nr'] = get_nr(diagnostic)
        })
      end
    end
  end

  if not vim.tbl_isempty(ale_diagnostics) then
    vim.api.nvim_call_function('ale#other_source#ShowResults', { bufnr, ale_source, ale_diagnostics })
  end
end

return M
