class MasterFormatter
  attr_reader :formatters

  def initialize(*formatters)
    @formatters = formatters.flatten
  end 

  def format(html_doc)
    @formatters.inject(html_doc) do |doc, formatter|
      doc = formatter.format(doc)
    end
  end
end