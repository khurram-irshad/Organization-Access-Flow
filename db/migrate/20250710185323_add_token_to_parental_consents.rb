class AddTokenToParentalConsents < ActiveRecord::Migration[8.0]
  def change
    add_column :parental_consents, :token, :string
    add_index :parental_consents, :token, unique: true
  end
end
