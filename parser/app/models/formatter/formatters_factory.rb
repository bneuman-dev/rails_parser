require_relative 'finders'
require_relative 'formatters'
require_relative 'rules_helper'

class FormattersFactory
  def initialize(config)
    @config = config
    @@text_formatter ||= Text_Formatter.new
    @@formatters = make_formatters
  end

  def config
    @config
  end

  def self.formatters
    @@formatters
  end

  def self.get_formatter(url)
    key = self.formatters.keys.find {|url_key| url.include? url_key}
    self.formatters[key] if key != nil
  end

  def make_formatters
    formatter_hash = {}
    @config.each do |url, formatter_config|
      formatters = make_formatters_array(formatter_config)
      formatters.push(@@text_formatter)
      formatter_hash[url] = Formatters.new(formatters)
    end
    formatter_hash
  end

  def make_formatters_array(formatter_config)
    formatter_config.collect {|line| Formatter.new(line[0].new(line[1]), delete=line.fetch(2, false))}
  end
end

class Configurator
  attr_reader :config_hash

  def initialize(records)
    @entries = records
    @config_hash = make_config
  end

  def make_config
    @entries.inject(Hash.new) do |config_hash, entry|
      config_hash[entry.url] = make_formatter_config(entry)
      config_hash  
      end
  end

  def make_formatter_config(config_line)
    good_rules = rule_helper(config_line.good_rules)
    bad_rules = rule_helper(config_line.bad_rules)
    config_array = []
    config_array << [CSS_Finder, good_rules]
    config_array << [CSS_Finder, bad_rules, true]
 #   config_array << [String_Finder, config_line.string_rules, true]
    config_array
  end
end

#CHANGE THIS!!!
#config = Configurator.new(Scraper.all)
#FormattersFactory.new(config)