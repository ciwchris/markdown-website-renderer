require 'rubygems'
require 'redcarpet'
require 'git'

renderer = Redcarpet::Render::HTML.new(:no_links => true, :hard_wrap => true)
markdown = Redcarpet::Markdown.new(renderer)

g = Git.open('.')
tree = g.gtree('master')
tree.files.each do |f|
	if (f.first.end_with?('.md'))
		puts markdown.render(g.cat_file(f[1]))
	end
end

tree.subdirectories.each do |d|
	subtree = g.gtree(d[1])
	subtree.files.each do |f|
		if (f.first.end_with?('.md'))
			puts markdown.render(g.cat_file(f[1]))
		end
	end
end
