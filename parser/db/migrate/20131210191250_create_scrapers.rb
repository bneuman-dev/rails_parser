class CreateScrapers < ActiveRecord::Migration
  def change
    create_table :scrapers do |t|
      t.string :url
      t.text :html_head
      t.text :html_body
      t.text :bad_rules
      t.text :good_rules
      t.text :mod_html
      t.string :new

      t.timestamps
    end
  end
end
