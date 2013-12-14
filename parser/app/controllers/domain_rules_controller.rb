class DomainRulesController < ApplicationController
  def new
  end

  def create
  	scrapings = Scraper.find(params[:id])
  	parsed_url = scrapings.url[/.*(.com|.net|.org)/]
  	parsed_url.gsub!("http://", "") if parsed_url.include? "http://"
  	
  	rule_url = DomainRule.select(:url).find {|rule| parsed_url.include? rule.url}

  	if rule_url == nil
  		@domain_rule = DomainRule.create(url: parsed_url, good_rules: scrapings.good_rules, bad_rules: scrapings.bad_rules)

  	else
  		@domain_rule = DomainRule.find_by_url(parsed_url)
      @domain_rule.good_rules = merge_new_rules(@domain_rule.good_rules, scrapings.good_rules) unless scrapings.good_rules == nil
      @domain_rule.bad_rules = merge_new_rules(@domain_rule.bad_rules, scrapings.bad_rules) unless scrapings.bad_rules == nil
      @domain_rule.save
    end

  	redirect_to scrapings
  end

  def index
    @domains = DomainRule.all
  end

  def merge_new_rules(domain_rules, scraping_rules)
    domain_parsed = JSON.parse(domain_rules)
    scraping_parsed = JSON.parse(scraping_rules)
    scraping_parsed.each do |rule|
      domain_parsed.push(rule) unless domain_parsed.include? rule
    end
    JSON.generate(domain_parsed)
  end
end


