json.countries @countries do |country|
  json.country country.english_name
  json.total_cases country.total_cases
  json.total_active_cases country.total_active_cases
  json.total_death_cases country.total_death_cases
  json.total_recovered_cases country.total_recovered_cases
  json.new_cases country.daily_information.by_date(Date.current).try(:first).try(:new_cases)
  json.new_deaths country.daily_information.by_date(Date.current).try(:first).try(:new_deaths)
end
