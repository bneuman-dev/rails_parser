require 'json'

def rule_helper(rules)
  JSON.parse(rules, symbolize_names: true)
end