class CreateCovidInformations < ActiveRecord::Migration[6.0]
  def change
    create_table :covid_informations do |t|
      t.references :country, null: false, foreign_key: true
      t.integer :active_cases
      t.integer :deaths
      t.integer :recovered

      t.timestamps
    end
  end
end
