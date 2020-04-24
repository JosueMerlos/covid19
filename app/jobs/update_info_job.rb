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
      next if country.total_active_cases.to_i.eql?(row_array[6].gsub(',', '').strip.to_i) &&
              country.total_cases.to_i.eql?(row_array[1].gsub(',', '').strip.to_i)

      covid_information = CovidInformation.find_or_initialize_by(country_id: country.id, date_event: Date.current)
      recovered_cases = row_array[5].try(:gsub, ',', '').try(:strip).try(:to_i)
      death_cases = row_array[3].gsub(',', '').try(:strip).try(:to_i)
      new_cases = row_array[2].gsub('+', '').gsub(',', '').try(:strip).try(:to_i)

      covid_information.attributes = {
        new_cases: new_cases,
        new_deaths: covid_information.new_deaths.to_i + (death_cases - country.total_death_cases),
        recovered: covid_information.recovered.to_i + (recovered_cases - country.total_recovered_cases)
      }
      covid_information.save

      puts "#{row_array[0].strip} updated!"
    end
  end
end
