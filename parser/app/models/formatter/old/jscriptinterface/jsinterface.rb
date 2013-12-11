require 'nokogiri'
require 'open-uri'

class JSInterfacer
	attr_reader :files

	def initialize(config=js_interface)
		@head = config.css('head').reverse
		@body = config.css('body').reverse
		@files = {}
	end

	def add_interface(url)
		doc = Nokogiri::HTML(open(url))
		head = doc.css('head')
		body = doc.css('body')

		@head.each {|rule| head.children[0].add_previous_sibling(rule)}
		@body.each {|rule| body.children[0].add_previous_sibling(rule)}
		doc
	end

	def make_file(url)
		interfaced = add_interface(url)
		formatted = interfaced.serialize()
		fn = url.split('/')[-1]
		fn += ".html" unless fn.include? 'html'
		file = File.open(fn, 'w')
		file.write(formatted)
		file.close
		@files[url] = fn
		fn
	end

end

def js_interface
	Nokogiri::HTML(open('jsinterface.html'))
end