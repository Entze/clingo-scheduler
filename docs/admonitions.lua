
local function is_applicable(elem)
  for _,classes in ipairs(elem.classes) do
    for class in classes:gmatch("%w+") do
      if class == "admonition" or class == "admonition-title" then
        return true
      end
    end
  end
  return false
end

function Div(elem)
  if is_applicable(elem) then
    local inner_pandoc = pandoc.Pandoc(elem.content)
    local inner_text = pandoc.write(inner_pandoc, 'markdown')
    local inner_rawblock = pandoc.RawBlock('html', inner_text)
    local div = pandoc.Div({inner_rawblock}, elem.attr)
    local pandoc_ = pandoc.Pandoc({div})
    local text = pandoc.write(pandoc_, 'html')
    local raw_block = pandoc.RawBlock('html', text)
    return raw_block
  end
end
