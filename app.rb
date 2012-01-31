require 'rubygems'
require 'sinatra'
require 'redcarpet'
require 'find'

class MarkdownRenderer
	def initialize ()
		@content = {}
		renderer = Redcarpet::Render::HTML.new(:no_links => true, :hard_wrap => true)
		@markdown = Redcarpet::Markdown.new(renderer)
	end

	def start_search
		Dir['**/*.md'].each {|fileName|
			name = create_tab_name_from(fileName)
			file = File.open(fileName)
			@content[name] = @markdown.render(file.read)
		}
		@content
	end

	private

	def create_tab_name_from(name)
		File.basename(name, '.md').gsub(/[-_]/, ' ').capitalize
	end
end

get '/' do
	content = MarkdownRenderer.new.start_search
	erb :index, :locals => { :content => content }
end
