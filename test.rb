require 'rubygems'
require 'redcarpet'
require 'git'

class MarkdownRenderer
	def initialize ()
		@content = {}
		renderer = Redcarpet::Render::HTML.new(:no_links => true, :hard_wrap => true)
		@markdown = Redcarpet::Markdown.new(renderer)
		@g = Git.open('.')
	end

	def start_search
		tree = @g.gtree('Setup')
		render_markdown_files(tree)
		search_directories(tree)
		@content
	end

	private

	def render_markdown_files(tree)
		tree.files.keys.each do |f|
			if (f.end_with?('.md'))
				@content[f] = @markdown.render(@g.cat_file(tree.files[f].to_s))
			end
		end
	end

	def search_directories(tree)
		return if tree == nil
		tree.subdirectories.keys.each do |d|
			subtree = @g.gtree(tree.subdirectories[d])
			render_markdown_files(subtree)
			search_directories(subtree)
		end
	end
end

content = MarkdownRenderer.new.start_search
0.upto((content.keys.length) -1) {|i| puts content.keys[i] + content[content.keys[i]]}

