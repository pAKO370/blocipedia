module ApplicationHelper

 def markdown#(text)
    #Redcarpet.new(text).to_html
   Redcarpet::Markdown.new(Redcarpet::Render::HTML)
 end


  
end
