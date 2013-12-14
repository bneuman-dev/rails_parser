require 'nokogiri'
require 'open-uri'
require_relative 'formatters'

class String_Finder
  attr_reader :checks, :finders
	def initialize(config)
		@config = config
		@checks = make_checks
    @finders = make_finders
	end

	def make_checks
    @config.collect {|line| make_check(line.chomp)}
  end

  def make_finders
    @checks.collect {|check| make_finder(check)}
  end

  def find(nodeset)
    @finders.collect {|finder| finder.call(nodeset)}.reduce(:+)
  end

  def make_check(string)
    "//*[text()[contains(.,'#{string}')]]"  
  end

  def make_finder(xpath_check)
    Proc.new { |nodeset| nodeset.search(xpath_check)}
  end
end

class CSS_Finder
  attr_reader :checks, :finders
  def initialize(config)
    @rules = config
    @css_selectors = make_css_selectors
    @finders = make_finders
  end

  def find(nodeset)
    @finders.collect {|finder| finder.call(nodeset)}.reduce(:+)
  end

  def make_css_selectors
   @rules.collect {|rule| 
      make_css_selector(rule[:name], rule[:attributes]) 
    }
  end

  def make_css_selector(name, attributes)
    attr_checks = attributes.collect do |attribute|
      make_attr_specifier(attribute[:name], attribute[:values])
    end
    name + attr_checks.join
  end

  def make_attr_specifier(attr, vals)
    vals.collect {|val| "[#{attr}*='#{val}']"}
  end

  def make_finders
    @css_selectors.collect {|css_selector| make_finder(css_selector)}
  end

  def make_finder(css_selector)
    Proc.new { |nodeset| nodeset.css(css_selector)}
  end 
end



