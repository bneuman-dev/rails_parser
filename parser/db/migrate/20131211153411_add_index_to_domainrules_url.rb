class AddIndexToDomainrulesUrl < ActiveRecord::Migration
  def change
  	add_index :domain_rules, :url, unique: true
  end
end
