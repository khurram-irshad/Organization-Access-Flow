class CreateContents < ActiveRecord::Migration[8.0]
  def change
    create_table :contents do |t|
      t.string :title
      t.text :description
      t.string :content_rating
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
