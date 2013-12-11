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
    @config = config
    @checks = make_checks
    @finders = make_finders
  end
  
  def make_checks
    @config.collect {|line| make_check(line)}
  end

  def make_finders
    @checks.collect {|check| make_finder(check)}
  end

  def find(nodeset)
    @finders.collect {|finder| finder.call(nodeset)}.reduce(:+)
  end

  def make_check(line)
    name, attrs = line.split('|')
    attr_checks = process_attrs(attrs)
    name + attr_checks.join
  end

  def process_attrs(attrs)
    attrs.split(':::').collect do |attr|
    	attr, vals = attr.split(' ')  #inject attr_dict instead?
      vals = vals.split(',')
      make_css_attr_checks(attr, vals)
  	end
  end

  def make_css_attr_checks(attr, vals)
    return "" if attr == "None"
    vals.collect {|val| "[#{attr}*='#{val}']"}
  end

  def make_finder(css_check)
    Proc.new { |nodeset| nodeset.css(css_check)}
  end
end
