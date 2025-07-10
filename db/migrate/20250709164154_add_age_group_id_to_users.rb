class AddAgeGroupIdToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :age_group_id, :bigint
  end
end
