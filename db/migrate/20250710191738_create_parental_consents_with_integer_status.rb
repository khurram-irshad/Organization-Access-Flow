class CreateParentalConsentsWithIntegerStatus < ActiveRecord::Migration[8.0]
  def change
    drop_table :parental_consents if table_exists?(:parental_consents)
    
    create_table :parental_consents do |t|
      t.references :user, null: false, foreign_key: true
      t.string :parent_email
      t.integer :status, default: 0, null: false
      t.string :token
      t.timestamps null: false
      
      t.index :token, unique: true
    end
  end
end