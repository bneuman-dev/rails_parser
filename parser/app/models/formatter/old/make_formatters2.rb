require_relative 'finders'
require_relative 'formatters'

class FormattersFactory
  def initialize(config='config.txt')
    @config = config
    @@formatters = make_formatters
  end

  def config
    @config
  end

  def self.formatters
    @@formatters
  end

  def make_formatters
    open(@config).inject(Hash.new) do |formatters, config_line|  
      config_line.chomp!                                  
      url, config_line = config_line.split('|')
      config_array = make_config_array(config_line)
      formatters[url] = Formatters.new(config_array)
      formatters                
    end
  end

  def make_config_array(config_line)
    config_array = []
    cfg = config_line.split(' ')
    cfg.collect! {|fname| fname + '.txt'}
    config_array << [CSS_Finder, open(cfg[0])]
    config_array << [CSS_Finder, open(cfg[1]), true]
    config_array << [String_Finder, open(cfg[2]), true]
    config_array
  end
end
