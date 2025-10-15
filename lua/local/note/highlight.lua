local custom_highlights = {
--    { "- \\[ \\]", "black", "#fac4fb" },
    -- { "- \\[[ a-zA-Z0-9_]\\]", "black", "#fac4fb" },
    -- { "  \\[[ x]\\]", "black", "#fac4fb" },
    { "  \\[[x]\\]", "black", "#fac4fb" },
    { "\\[[✓]\\]", "black", "#7fff00" },
    { "\\[[c]\\]", "black", "#6c7086" },
    -- { "\\[[✓]\\]", "black", "#808080" },
    { "\\[[ ]\\]", "black", "#8000FF" },
    -- { "\\[[ ]\\]", "black", "purple" },
    -- { "\\[[ ]\\]", "black", "#fac4fb" },
    -- { "\\[[ ]\\]", "black", "#8A4FFF" },
    -- { "\\[[ ]\\]", "black", "#8a2be2" },
    { "•", "black", "#49B6FF" },
    { "*", "black", "magenta" },
    { "#.*", "black", "#6c7086" },
    -- { "• ([ a-zA-Z0-9_])", "black", "#fac4fb" },
    -- { "\\* \\[[ a-zA-Z0-9_]\\]", "black", "#fac4fb" },
    { "[[][a-zA-Z0-9]*[]]", "black", "#fac4fb" },
    -- { "%b()", "black", "#fac4fb" },
    -- { "\\[[a-zA-Z0-9_]\+\\]", "black", "#fac4fb" },
    -- { "\[[^\]]+\]*", "black", "#fac4fb" },
    { "\\[a-zA-Z0-9_]*", "black", "red" },
    { "@[a-zA-Z0-9_]*", "black", "#9C89B8" },
    { "@error", "black", "#8b0000" },
    { "@warn", "black", "#EDF67D" },
    { "@debug", "black", "#ffa07a" },
    { "@feature", "black", "#A663CC" },
    { "@format", "black", "#5C4D7D" },
    { "@buy", "black", "#ff69b4" },
    { "@sell", "black", "#adff2f" },
}

local ntag = 0
local highlight_ids = {}
local unique_tags = {}

-- local palette1 = {
--     "#f0e68c", "#e6e6fa", "#ff4500", "#2e8b57", "#8a2be2", "#7fffd4", "#d2691e", 
--     "#ff69b4", "#1e90ff", "#adff2f", "#4b0082", "#8b0000", "#ffe4b5", "#deb887",
--     "#ff6347", "#00ced1", "#ffa07a"
-- }

local palettes = {
  -- { "red", "blue", "#7fff00", "yellow", "cyan", "magenta", "orange", "purple", "pink", "#bbbeff", "#abcdef", "#ffffff", "#dc143c", "#c3447a" },#0000FF #ff94fb
  {"#CDB4DB", "#FFC8DD", "#FFAFCC", "#BDE0FE", "#A2D2FF"},
  {"#FDC5F5", "#F7AEF8", "#B388EB", "#8093F1", "#72DDF7"},
  {"#FF499E", "#D264B6", "#A480CF", "#779BE7", "#49B6FF"},
  {"#E574BC", "#EA84C9", "#EF94D5", "#F9B4ED", "#EABAF6", "#DABFFF", "#C4C7FF", "#ADCFFF", "#96D7FF", "#7FDEFF"},
  -- {"#880D1E", "#DD2D4A", "#F26A8D", "#F49CBB", "#CBEEF3"},
  {"#5540E3", "#1A0699", "#F0F0F0", "#E053CE", "#45C5D9"},
  {"#7BDFF2", "#B2F7EF", "#EFF7F6", "#F7D6E0", "#F2B5D4"},
  {"#FF5883", "#FF91AD", "#FEC9D7", "#B9EEE1", "#79D3BE", "#39B89A"},
  {"#07BEB8", "#3DCCC7", "#68D8D6", "#9CEAEF", "#C4FFF9"},
  {"#FFADAD", "#FFD6A5", "#FDFFB6", "#CAFFBF", "#9BF6FF", "#A0C4FF", "#BDB2FF", "#FFC6FF", "#FFFFFC"},
  {"#FF99C8", "#FCF6BD", "#D0F4DE", "#A9DEF9", "#E4C1F9"},
  {"#FBF8CC", "#FDE4CF", "#FFCFD2", "#F1C0E8", "#CFBAF0", "#A3C4F3", "#90DBF4", "#8EECF5", "#98F5E1", "#B9FBC0"},
  {"#FFCBF2", "#F3C4FB", "#ECBCFD", "#E5B3FE", "#E2AFFF", "#DEAAFF", "#D8BBFF", "#D0D1FF", "#C8E7FF", "#C0FDFF"},
  -- {"#B7094C", "#A01A58", "#892B64", "#723C70", "#5C4D7D", "#455E89", "#2E6F95", "#1780A1", "#0091AD"},
  {"#FFD6FF", "#E7C6FF", "#C8B6FF", "#B8C0FF", "#BBD0FF"},
  {"#5AA9E6", "#7FC8F8", "#F9F9F9", "#FFE45E", "#FF6392"},
  {"#87C4F2", "#5EAFF2", "#FCABD8", "#F877B1", "#FFE799"},
  {"#70D6FF", "#FF70A6", "#FF9770", "#FFD670"},
  {"#DEC5E3", "#CDEDFD", "#B6DCFE", "#A9F8FB", "#81F7E5"},
  {"#970005", "#ED0101", "#FFFFFF", "#0C44AC", "#000052"},
  {"#D6D2D2", "#F1E4F3", "#F4BBD3", "#F686BD", "#FE5D9F"},
  {"#8E9AAF", "#CBC0D3", "#EFD3D7", "#FEEAFA", "#DEE2FF"},
  {"#FFFFFF", "#EFFFFA", "#E5ECF4", "#C3BEF7", "#8A4FFF"},
  {"#564787", "#DBCBD8", "#F2FDFF", "#9AD4D6", "#101935"},
  {"#F72585", "#7209B7", "#3A0CA3", "#4361EE", "#4CC9F0"},
  {"#BEE9E8", "#62B6CB", "#1B4965", "#CAE9FF", "#5FA8D3"},
  {"#9C89B8", "#F0A6CA", "#EFC3E6", "#F0E6EF", "#B8BEDD"},
  {"#6F2DBD", "#A663CC", "#B298DC", "#B8D0EB", "#B9FAF8"},
  {"#6E44FF", "#B892FF", "#FFC2E2", "#FF90B3", "#EF7A85"},
  {"#EFD9CE", "#DEC0F1", "#B79CED", "#957FEF", "#7161EF"},
  {"#9381FF", "#B8B8FF", "#F8F7FF", "#FFEEDD", "#FFD8BE"},
  {"#E5D9F2", "#F5EFFF", "#CDC1FF", "#A594F9", "#7371FC"},
  {"#9667E0", "#D4BBFC", "#EBD9FC", "#F2EBFB", "#FBFAFF"},
  {"#5603AD", "#8367C7", "#B3E9C7", "#C2F8CB", "#F0FFF1"},
  {"#5E2BFF", "#C04CFD", "#FC6DAB", "#F7F6C5", "#F3FAE1"},
  {"#97DFFC", "#858AE3", "#613DC1", "#4E148C", "#2C0735"},
  {"#EBC2FF", "#A873E8", "#5D7BD5", "#56D1DC", "#C2FFEE"},
  {"#F992AD", "#FBBCEE", "#FAB4C8", "#F78ECF", "#CFB9F7", "#E0CEFD", "#A480F2", "#D4B0F9", "#C580ED"},
  {"#642CA9", "#FF36AB", "#FF74D4", "#FFB8DE", "#FFDDE1"},
  {"#F992AD", "#FBBCEE", "#FAB4C8", "#F78ECF", "#CFB9F7", "#E0CEFD", "#A480F2", "#D4B0F9", "#C580ED", "#D199F1"},
  {"#996FD6", "#A786DB", "#B59CE0", "#C2B3E5", "#D0C9EA"},
  {"#EDF67D", "#F896D8", "#CA7DF9", "#724CF9", "#564592"}
}

local tag_colors = vim.tbl_flatten({unpack(palettes)})

function is_allowed_for_highlighting()
    local allowed_folders = {'/notes', '/notes/daily', '/notes/notes/2024'}
    local current_folder = vim.fn.expand('%:p:h')
    for _, folder in ipairs(allowed_folders) do
        folder = vim.fn.expand('~' .. folder)
        if string.find(current_folder, folder, 1, true) then
            return true
        end
    end
end

function safe_matchdelete(id)
    if id and id ~= 0 then
        -- Проверяем, существует ли хайлайт с таким ID
        local status, result = pcall(vim.fn.matchdelete, id)
        if not status then
            -- Игнорируем ошибку "ID not found", логируем другие ошибки
            if not string.find(result, "ID not found") then
                print("Error deleting match:", result)
            end
        end
    end
end

function note_highlighting()
  -- for _, id in ipairs(highlight_ids) do
  --   vim.fn.matchdelete(id)
  -- end
  -- highlight_ids = {}

  for i, pair in ipairs(custom_highlights) do
    local word, color, background_color  = pair[1], pair[2], pair[3]
    -- if word == "\\[a-zA-Z0-9_]*" then
    if word == "[[][a-zA-Z0-9]*[]]" then
    -- if word == "[[][a-zA-Z0-9]*[]]" or word == "@[a-zA-Z0-9_]*" then
    -- if word == "[[][a-zA-Z0-9]*[]]" or word == "\\[a-zA-Z0-9_]*" then
      local content = table.concat(vim.fn.getline(1, '$'), '\n')
        
      for unique_tag, unique_color in pairs(unique_tags) do
        -- print(content:gmatch(vim.pesc(unique_tag)..'$'))
        -- if not content:gmatch(unique_tag) then
        -- if not content:match(unique_tag) then
        -- print(1, unique_tag, vim.fn.search(vim.pesc(unique_tag), 'nw'))
        -- print(2, unique_tag, content:find(unique_tag, 1, true))
        -- if not vim.fn.search(vim.pesc(unique_tag), 'nw') then
        -- if not content:find(unique_tag, 1, false) then
        if not content:find(unique_tag..'[\n| ]', 1, false) then
          print('not', unique_tag, highlight_ids[unique_tag])
          table.insert(tag_colors, unique_color)
          unique_tags[unique_tag] = nil
          safe_matchdelete(highlight_ids[unique_tag])
          -- vim.fn.matchdelete(highlight_ids[unique_tag]) 
          highlight_ids[unique_tag] = nil
        end 
      end

      local new_tags = content:gmatch(word)

      for tag in new_tags do
          if not unique_tags[tag] then
              math.randomseed(vim.loop.hrtime())
              local unique_color = table.remove(tag_colors, math.random(1, #tag_colors))
              unique_tags[tag] = unique_color
          end
      end

      for tag, unique_color in pairs(unique_tags) do
        if not highlight_ids[tag] then
          highlight_group = 'NHT' .. tostring(ntag)
          -- vim.cmd(string.format('hi %s guifg=black guibg=%s', highlight_group, unique_color))
          vim.cmd(string.format('hi %s guifg=%s', highlight_group, unique_color))
          local id = vim.fn.matchadd(highlight_group, '\\'..tag, #tag)
          print(tag, highlight_group, id)
          highlight_ids[tag] = id
          ntag = ntag + 1
        end
      end
    elseif pattern == '#.*' then
      local highlight_group = 'NH' .. tostring(i)
          vim.cmd(string.format('hi %s cterm=italic gui=italic guifg=%s', highlight_group, background_color))
      
    else
      local highlight_group = 'NH' .. tostring(i)
      
      if background_color then
          -- vim.cmd(string.format('hi %s guifg=%s guibg=%s', highlight_group, color, background_color))
          vim.cmd(string.format('hi %s guifg=%s', highlight_group, background_color))
      else
          vim.cmd(string.format('hi %s guifg=%s', highlight_group, color))
      end
      local id = vim.fn.matchadd(highlight_group, word, 10)
      -- highlight_ids[word] = id
    end
  end
end

-- vim.api.nvim_exec([[
--   augroup NoteHighlighting
--     autocmd BufEnter,TextChanged,TextChangedI * lua if is_allowed_for_highlighting() then note_highlighting() end
--   augroup end
-- ]],false)
vim.api.nvim_exec([[
  augroup NoteHighlighting
    autocmd BufEnter,InsertLeave * lua if is_allowed_for_highlighting() then note_highlighting() end
  augroup end
]],false)
