local M = {}
local SOURCE = 'nvim-lsp'

---NR code from lsp code
---@param diagnostic table
---@return number
local function get_nr(diagnostic)
  if diagnostic.user_data and diagnostic.user_data.lsp and diagnostic.user_data.lsp.code then
    return diagnostic.user_data.lsp.code
  end

  return ''
end

---Filename from bufnr
---@param diagnostic table
---@return string
local function get_filename(diagnostic)
  return vim.api.nvim_buf_get_name(diagnostic.bufnr)
end

---Severity Mapping
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

---Notify ALE on diagnostic change of "nvim-lsp" source
---@return nil
function M.notify_ale()
  local ale_diagnostics = {}
  local lsp_diagnostics = vim.diagnostic.get()
  local bufnr = vim.api.nvim_get_current_buf()

  if not vim.tbl_isempty(lsp_diagnostics) then
    for _, diagnostic in pairs(lsp_diagnostics) do
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

  vim.call('ale#other_source#ShowResults',  bufnr, SOURCE, {})

  if not vim.tbl_isempty(ale_diagnostics) then
    vim.call('ale#other_source#ShowResults',  bufnr, SOURCE, ale_diagnostics)
  end
end

---Start checking the "nvim-lsp" source
---@return nil
function M.start_check()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.call('ale#other_source#StartChecking',  bufnr, SOURCE)
end

return M
