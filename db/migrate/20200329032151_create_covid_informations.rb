class CreateCovidInformations < ActiveRecord::Migration[6.0]
  def change
    create_table :covid_informations do |t|
      t.references :country, null: false, foreign_key: true
      t.integer :new_cases
      t.integer :new_deaths
      t.integer :recovered
      t.date :date_event

      t.timestamps
    end
  end
end
