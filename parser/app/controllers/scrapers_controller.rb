require '/users/bneuman/rails-parser/parser/app/models/formatter/strippers'

class ScrapersController < ApplicationController


	def create
		url = params[:scrapings][:url]
		noko = nokoify(url)
		@scraper = Scraper.create(url: url, html_head: noko[:head], html_body: noko[:body])
		redirect_to @scraper
	end

	def show
		@scraper = Scraper.find(params[:id])
		@scraper.save
	end

	def nokoify(url)
		doc = Nokogiri::HTML(open(url))
		head = doc.css('head')[0]
		body = doc.css('body')[0]
		noko_string = {head: head.serialize, body: body.serialize}
		
		##fn = url.split('/')[-1]
		#fn += ".html" unless fn.include? 'html'
		#file = File.open(fn, 'w')
		#file.write(noko_string)
		#file.close
		#fn
	end
	
	def edit
		@scraper = Scraper.find(params[:id])
		@scraper.good_rules = params[:good].to_s
		@scraper.bad_rules = params[:bad].to_s
		@scraper.save
		render nothing: true
	end

	def update
		FormattersFactory.new(Configurator.new(Scraper.all).config_hash)
		@scraper = Scraper.find(params[:id])
		@scraper.mod_html = HTML_Doc.new(@scraper.url).processed_doc
		@scraper.save
		render
	end
	
end
