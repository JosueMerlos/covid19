class UpdateInfoJob < ApplicationJob
  queue_as :default

  def perform
    require 'nokogiri'
    require 'open-uri'
    doc = Nokogiri::HTML(open('https://www.worldometers.info/coronavirus/#countries'))

    rows = doc.css('#main_table_countries_today > tbody > tr')
    rows.each do |row|
      row_array = row.content.split(/\n/)
      row_array.shift
      next if row_array[0].strip.match?('Total') || row_array[0].strip.empty?

      active_cases = row_array[6].try(:gsub, ',', '').try(:strip).try(:to_i)
      total_cases = row_array[1].try(:gsub, ',', '').try(:strip).try(:to_i)
      country_name = row_array[0].strip.match?('World') ? 'Global' : row_array[0].strip
      country = Country.find_or_create_by(english_name: country_name)
      next if country.total_active_cases.to_i.eql?(active_cases) && country.total_cases.to_i.eql?(total_cases)

      covid_information = country.covid_information
      daily_information = DailyInformation.find_or_initialize_by(country_id: country.id, date_event: Date.current)

      death_cases = row_array[3].gsub(',', '').try(:strip).try(:to_i)

      covid_information.attributes = {
        recovered: row_array[5].try(:gsub, ',', '').try(:strip).try(:to_i),
        deaths: row_array[3].gsub(',', '').try(:strip).try(:to_i),
        active_cases: active_cases
      }
      covid_information.save

      daily_information.attributes = {
        new_cases: row_array[2].gsub('+', '').gsub(',', '').try(:strip).try(:to_i),
        new_deaths: row_array[4].gsub('+', '').gsub(',', '').try(:strip).try(:to_i)
      }
      daily_information.save

      puts "#{country_name} updated!"
    end
  end
end
