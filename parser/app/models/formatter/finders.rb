require 'nokogiri'
require 'open-uri'

class Finder
  attr_reader :finders

  def initialize(config)
    @finders = config[:finder_class].new(config[:finder_rules]).finders
  end

  def find(nodeset)
    @finders.collect {|finder| finder.call(nodeset)}.reduce(:+)
  end
end

class CSS_Finder
  attr_reader :finders
  def initialize(rules)
    @rules = rules
    @selectors = make_selectors
    @finders = make_finders
  end

  def make_selectors
    @rules.collect {|rule| CSS_Selector.new(rule).selector}
  end

  def make_finders
    @selectors.collect {|selector| make_finder(selector)}
  end

  def make_finder(selector)
    Proc.new { |nodeset| nodeset.css(selector)}
  end 
end

class CSS_Selector
  attr_reader :selector

  def initialize(rule)
    @name = rule[:name]
    @attributes = rule[:attributes]
    @selector = make_css_selector
  end

  def make_css_selector
    @name + @attributes.collect {|attribute| make_attr_specifier(attribute)}.join
  end
  
  def make_attr_specifier(attribute)
    attribute[:values].collect {|val| "[#{attribute[:name]}*='#{val}']"}
  end
end

class String_Finder
  attr_reader :checks, :finders
  def initialize(config)
    @rules = config
    @selectors = make_selectors
    @finders = make_finders
  end

  def make_selectors
    @rules.collect {|rule| make_selector(rule.chomp)}
  end

  def make_selector(string)
    "//*[text()[contains(.,'#{string}')]]"  
  end

  def make_finders
    @selectors.collect {|selector| make_finder(selector)}
  end  

  def make_finder(selector)
    Proc.new { |nodeset| nodeset.search(selector)}
  end
end