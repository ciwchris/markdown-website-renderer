require 'rubygems'
require 'redcarpet'
require 'git'

class MarkdownRenderer
	def initialize ()
		renderer = Redcarpet::Render::HTML.new(:no_links => true, :hard_wrap => true)
		@markdown = Redcarpet::Markdown.new(renderer)
		@g = Git.open('.')
	end

	def start_search
		tree = @g.gtree('Setup')
		render_markdown_files(tree)
		search_directories(tree)
	end

	private

	def render_markdown_files(tree)
		tree.files.each do |f|
			if (f.first.end_with?('.md'))
				puts @markdown.render(@g.cat_file(f[1]))
			end
		end
	end

	def search_directories(tree)
		return if tree == nil
		tree.subdirectories.each do |d|
			subtree = @g.gtree(d[1])
			render_markdown_files(subtree)
			search_directories(subtree)
		end
	end
end

MarkdownRenderer.new.start_search
