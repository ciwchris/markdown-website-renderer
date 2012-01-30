require 'rubygems'
require 'redcarpet'
require 'git'

g = Git.open('.')

puts g.index

#renderer = Redcarpet::Render::HTML.new(:no_links => true, :hard_wrap => true)
#markdown = Redcarpet::Markdown.new(renderer)
#puts markdown.render("text")
