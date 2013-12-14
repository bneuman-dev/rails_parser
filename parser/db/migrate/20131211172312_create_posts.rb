class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :url
      t.text :html
      t.text :f_html

      t.timestamps
    end
  end
end
