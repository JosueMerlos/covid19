class UpdateInfoJob < ApplicationJob
  queue_as :default

  def perform
    require 'nokogiri'
    require 'open-uri'
    doc = Nokogiri::HTML(open('https://www.worldometers.info/coronavirus/#countries'))

    rows = doc.css('#main_table_countries_today > tbody > tr')
    #row[0] Pais => Total:
    #row[1] casos totales => 663,740
    #row[2] nuevos casos => +662
    #row[3] muertes totales => 30,879
    #row[4] nuevas muertes => +23
    #row[5] total recuperados => 142,183
    #row[6] casos activos => 490,678
    #row[7] casos criticos => 25,207
    #row[8] tot casos sobre 1m pop => 85.2
    #row[9] tot muertes sobre 1m pop => 4.0
    #row[10] primer caso => date
    rows.each do |row|
      row_array = row.content.split(/\n/)
      row_array.shift
      next if row_array[0].strip.match?('Total') || row_array[0].strip.match?('World') || row_array[0].strip.empty?
      country = Country.find_or_create_by(english_name: row_array[0].strip)
      next if country.blank? || country.total_cases.eql?(row_array[1].gsub(',', '').strip.to_i)
      covid_information = CovidInformation.find_or_initialize_by(country_id: country.id, date_event: Date.current)
      covid_information.attributes = {
        new_cases: covid_information.new_cases.to_i + (row_array[6].gsub(',', '').strip.to_i - country.total_active_cases),
        new_deaths: covid_information.new_deaths.to_i + (row_array[3].gsub(',', '').strip.to_i - country.total_death_cases)
      }
      country.covid_information.update_all(recovered: 0)
      covid_information.recovered = row_array[5].try(:gsub, ',', '').try(:to_i)
      covid_information.save
      puts "#{row_array[0].strip} updated!"
    end
  end
end
