require_relative 'formatter'
require_relative 'text_formatter'
require_relative 'finders'

class Formatters
  attr_reader :formatters

  def initialize(config)
    @config = config
    @formatters = make_formatters
    @@text_formatter ||= Text_Formatter.new
    add_text_formatter
  end 

  def format(html_doc)
    @formatters.inject(html_doc) do |doc, formatter|
      doc = formatter.format(doc)
    end
  end

  def add_text_formatter
    @formatters << @@text_formatter
  end

  def make_formatters
    @config.collect {|cfg_line| Formatter.new(cfg_line[0].new(cfg_line[1]), delete=cfg_line.fetch(2, false))}
  end
end