require_relative 'formatters_factory'
require_relative 'configurators'
require_relative 'formatter'
require_relative 'master_formatter'
require_relative 'rules_helper'
require_relative 'text_formatter'
require 'nokogiri'
require 'open-uri'

class Stripper
  def initialize(url, doc)
    @formatter = get_formatter(url)
    @doc = doc                                  
    @processed_doc = format
  end

  def get_formatter(url)
    Formatters.get_formatter(url)
  end

  def formatter
    @formatter
  end

  def format
    formatter.format(@doc)
  end

  def doc
    @doc
  end

  def processed_doc
    @processed_doc
  end
end

class HTML_Doc
  def initialize(url)
    @url = url
    @doc = make_html_doc(url)
    @processed_doc = process_doc
  end

  def make_html_doc(url)
    html_doc = Nokogiri::HTML(open(url))
  end

  def process_doc
    Stripper.new(@url, @doc).processed_doc
  end

  def doc
    @doc
  end

  def processed_doc
    @processed_doc
  end
end