class CreateDomainRules < ActiveRecord::Migration
  def change
    create_table :domain_rules do |t|
      t.string :url
      t.text :good_rules
      t.text :bad_rules
      t.text :string_rules

      t.timestamps
    end
  end
end
