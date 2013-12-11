require 'json'

def rule_helper(rules)
	json_able = rules.gsub("=>", ":")
	parsed = JSON.parse(json_able)
	parsed.values.collect do |rule|
		rule_hash = {}
		rule_hash[:name] = rule['tag']['name'].downcase
		rule_hash[:attributes] = attr_helper(rule['tag']['attributes'])
		rule_hash
	end
end		

def attr_helper(attributes)
	attributes.values
end