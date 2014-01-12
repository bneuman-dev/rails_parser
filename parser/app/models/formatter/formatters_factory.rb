require_relative 'finders'
require_relative 'master_formatter'
require_relative 'text_formatter'
require_relative 'rules_helper'
require_relative 'formatter'

class Formatters
  def self.formatters
    @@formatters
  end

  def self.get_formatter(url)
    key = self.formatters.keys.find {|url_key| url.include? url_key}
    self.formatters[key] if key != nil
  end

  def self.make_formatters(config)
    @@formatters ||= {}
  
    config.each do |url, formatter_config|
      @@formatters[url] ||= FormatterFactory.new(formatter_config).master
    end
  end
end

class FormatterFactory
  attr_reader :formatters, :master
  def initialize(config)
    @@text_formatter ||= TextFormatter.new
    @config = config
    @formatters = make_formatters
    @master = make_master
  end

  def make_formatters
    @config.collect do |entry|
      finder = Finder.new(entry[0])
      Formatter.new(finder, delete=entry.fetch(1, false))
    end
  end

  def make_master
    MasterFormatter.new(@formatters, @@text_formatter)
  end
end