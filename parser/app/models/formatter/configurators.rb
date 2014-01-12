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
    string_rules = JSON.parse(config_line.string_rules)
    bad_rules << @script_rule
    config_array = [[{finder_class: CSS_Finder, finder_rules: good_rules}], 
                    [{finder_class: CSS_Finder, finder_rules: bad_rules}, true], 
                   [{finder_class: String_Finder, finder_rules: string_rules}, true],]
  end
end

def sql_configure(sql)
  Formatters.make_formatters(SQL_Configurator.new(sql).config_hash)
end

class Text_Configurator
  attr_reader :config_hash

  def initialize(text_file)
    @text = File.open(text_file)
    @dir_path = text_file.split('/')[0...-1].join('/')
    @dir_path += '/' unless @dir_path == ""
    @finder_type_hash = {'string' => String_Finder, 'css' => CSS_Finder}
    @config_hash = make_config
  end

  def make_config
    @text.inject(Hash.new) do |config_hash, line|
      url, rule_files = line.split('|')
      config_hash[url] = make_rules(rule_files.split(' '))
      config_hash
    end
  end

  def make_rules(rule_files)
    rule_files.collect do |file|
      finder_type, file = file.split(':')
      [{finder_class: @finder_type_hash[finder_type], finder_rules: parse_rule_file(file, finder_type)}]
    end
  end

  def parse_rule_file(file, finder_type)
    File.open(@dir_path + file).collect {|line| parse_rule_line(line)} if finder_type == 'css'
    File.open(@dir_path + file).collect {|line| line.chomp('\n')} if finder_type == 'string'
  end

  def parse_rule_line_css(line)
    tag_name, attributes = line.split('|')
    attributes = attributes.split(':::')
    attributes.collect! do |attribute|
      attr_name, vals = attribute.split(' ')
      {name: attr_name,
       values: vals.split(',')
      }
    end

    {name: tag_name, attributes: attributes}
  end

end