require_relative 'formatter'
require_relative 'text_formatter'
require_relative 'finders'

class Formatters
  attr_reader :formatters

  def initialize(formatters)
    @formatters = formatters
  end 

  def format(html_doc)
    @formatters.inject(html_doc) do |doc, formatter|
      doc = formatter.format(doc)
    end
  end
end