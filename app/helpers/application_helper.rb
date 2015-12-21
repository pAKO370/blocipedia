module ApplicationHelper

 def markdown
  renderer = Redcarpet::Render::HTML.new(hard_wrap: true)
   Redcarpet::Markdown.new(Redcarpet::Render::HTML)
 end


  
end
