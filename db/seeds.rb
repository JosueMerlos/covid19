# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
begin
  # require 'csv'
  # countries = CSV.read('config/initializers/countries.csv', :headers => true)
  require 'nokogiri'
  require 'open-uri'
  doc = Nokogiri::HTML(open('https://www.worldometers.info/coronavirus/#countries'))
  rows = doc.css('#main_table_countries_today > tbody > tr')
  rows.each do |row|
    row_array = row.content.split(/\n/)
    row_array.shift
    next if row_array[0].strip.match?('Total') || row_array[0].strip.empty?

    country_name = row_array[0].strip.match?('World') ? 'Global' : row_array[0].strip
    country = Country.find_or_create_by(
      english_name: country_name
    )

    CovidInformation.create(
      country_id: country.id,
      recovered: row_array[5].try(:gsub, ',', '').try(:to_i),
      active_cases: row_array[6].try(:gsub, ',', '').try(:to_i),
      deaths: row_array[3].gsub(',', '').try(:strip).try(:to_i)
    )

    DailyInformation.create(
      country_id: country.id,
      new_cases: row_array[2].gsub('+', '').gsub(',', '').try(:strip).try(:to_i),
      new_deaths: row_array[4].gsub('+', '').gsub(',', '').try(:strip).try(:to_i),
      date_event: Date.current
    )

    puts "#{country_name} created!"
  end
rescue StandardError => e
  puts e.message
end
