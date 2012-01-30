require 'rubygems'
require 'sinatra'
require 'redcarpet'

get '/' do
	markdown = Redcarpet.new("Hello World!")
	puts markdown.to_html
end
