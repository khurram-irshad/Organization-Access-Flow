class CreateAgeGroups < ActiveRecord::Migration[8.0]
  def change
    create_table :age_groups do |t|
      t.string :name
      t.integer :min_age
      t.integer :max_age

      t.timestamps
    end
  end
end
