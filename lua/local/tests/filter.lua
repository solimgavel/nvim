local ns_id = vim.api.nvim_create_namespace("FindDotsHighlight")

function HighlightDotsAfterDone()
  vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)

  local seen_done = false
  local line_count = vim.api.nvim_buf_line_count(0)

  for lnum = 0, line_count - 1 do
    local line = vim.api.nvim_buf_get_lines(0, lnum, lnum + 1, false)[1]
    if line:find("%[✓%]") then
      seen_done = true
    elseif seen_done and line:find("•") then
      vim.api.nvim_buf_add_highlight(0, ns_id, "Visual", lnum, 0, -1)
    end
  end
end

vim.api.nvim_create_user_command("F", HighlightDotsAfterDone, {})
