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
	end
	
	def edit
		@scraper = Scraper.find(params[:id])
		@scraper.good_rules = save_rules_helper(params[:good]) unless params[:good] == nil
		@scraper.bad_rules = save_rules_helper(params[:bad]) unless params[:bad] == nil
		@scraper.save
		render nothing: true
	end

	def update
		scraper = Scraper.find(params[:id])
		redirect_to edit_post_path(url: scraper.url) 
		#WANT TO REDIRECT TO posts CREATE ACTION
	end

	def save_rules_helper(rules)
		rules_formatted = rules.values.collect do |rule|
			{name: rule['name'].downcase,
				attributes: attr_helper(rule['attributes'].values),}
		end
		JSON.generate(rules_formatted).gsub("=>", ":")
	end
	
	def attr_helper(attributes)
		attributes.reject! {|attribute| attribute['name'] == 'style'}
		attributes.collect do |attribute|
			{name: attribute['name'],
			values: attribute['values'].split(' '),}
		end
	end

end
