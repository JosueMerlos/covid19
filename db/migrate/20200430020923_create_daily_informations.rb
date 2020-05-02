class CreateDailyInformations < ActiveRecord::Migration[6.0]
  def change
    create_table :daily_informations do |t|
      t.references :country, null: false, foreign_key: true
      t.integer :new_cases
      t.integer :new_deaths
      t.date :date_event

      t.timestamps
    end
  end
end
