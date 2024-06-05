
function Link(elem)
  if string.match(elem.target, ".+%.dj") then
    local target = string.gsub(elem.target, "%.dj", ".md")
    return pandoc.Link(elem.content, target, elem.title, elem.attr)
  end
end
