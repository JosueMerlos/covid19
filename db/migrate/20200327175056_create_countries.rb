class CreateCountries < ActiveRecord::Migration[6.0]
  def change
    create_table :countries do |t|
      t.string :english_name
      t.string :spanish_name
      t.string :iso3, limit: 3

      t.timestamps
    end
    # add_index :countries, :iso3, unique: true
  end
end
