require 'rubygems'
require 'sinatra'
require 'redcarpet'
require 'git'

class MarkdownRenderer
	def initialize ()
		@content = {}
		renderer = Redcarpet::Render::HTML.new(:no_links => true, :hard_wrap => true)
		@markdown = Redcarpet::Markdown.new(renderer)
		@g = Git.open('git@heroku.com:glowing-waterfall-8567.git')
	end

	def start_search
		tree = @g.gtree('master')
		render_markdown_files(tree)
		search_directories(tree)
		@content
	end

	private

	def render_markdown_files(tree)
		tree.files.keys.each do |f|
			if (f.end_with?('.md'))
				key = create_key_from(f)
				@content[key] = @markdown.render(@g.cat_file(tree.files[f].to_s))
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

	def create_key_from(key)
		key.sub(/\.md$/, '').gsub(/[-_]/, ' ').capitalize
	end
end

get '/' do
	content = MarkdownRenderer.new.start_search
	erb :index, :locals => { :content => content }
end
