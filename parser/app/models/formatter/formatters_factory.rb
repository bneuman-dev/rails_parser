require_relative 'finders'
require_relative 'formatters'
require_relative 'rules_helper'

class FormattersFactory
  def self.formatters
    @@formatters
  end

  def self.get_formatter(url)
    key = self.formatters.keys.find {|url_key| url.include? url_key}
    self.formatters[key] if key != nil
  end

  def self.make_formatters(config)
    @@text_formatter ||= Text_Formatter.new
    @@formatters ||= {}
    
    config.each do |url, formatter_config|
      formatters = make_formatters_array(formatter_config)
      formatters.push(@@text_formatter)
      @@formatters[url] ||= Formatters.new(formatters)
    end
  end

  def self.make_formatters_array(formatter_config)
    formatter_config.collect {|line| Formatter.new(line[0].new(line[1]), delete=line.fetch(2, false))}
  end
end

class SQL_Configurator
  attr_reader :config_hash, :script_rule

  def initialize(records)
    @entries = records
    @script_rule = {name: 'script', attributes: []}
    @config_hash = make_config
  end

  def make_config
    @entries.inject(Hash.new) do |config_hash, entry|
      config_hash[entry.url] = make_formatter_config(entry)
      config_hash  
      end
  end

  def make_formatter_config(config_line)
    good_rules = JSON.parse(config_line.good_rules, symbolize_names: true)
    bad_rules = JSON.parse(config_line.bad_rules, symbolize_names: true)
    bad_rules << @script_rule
    config_array = []
    config_array << [CSS_Finder, good_rules]
    config_array << [CSS_Finder, bad_rules, true]
 #  config_array << [String_Finder, string_rules, true]
    config_array
  end
end

def sql_configure(sql)
  FormattersFactory.make_formatters(SQL_Configurator.new(sql).config_hash)
end


#CHANGE THIS!!!
#config = Configurator.new(Scraper.all)
#FormattersFactory.new(config)