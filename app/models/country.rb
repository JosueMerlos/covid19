class Country < ApplicationRecord

  # validates :spanish_name, presence: true
  validates :english_name, presence: true
  # validates :iso3, presence: true, uniqueness: true
  has_one :covid_information
  has_many :daily_information

  def self.search(txt_search)
    where('english_name ilike ?', ['%', txt_search.try(:strip), '%'].join)
  end

  def total_cases
    total_active_cases + total_death_cases + total_recovered_cases
  end

  def total_active_cases
    covid_information.active_cases.to_i
  end

  def total_death_cases
    covid_information.deaths.to_i
  end

  def total_recovered_cases
    covid_information.recovered.to_i
  end

end
