class Country < ApplicationRecord

  # validates :spanish_name, presence: true
  validates :english_name, presence: true
  # validates :iso3, presence: true, uniqueness: true
  has_many :covid_information

  def self.search(txt_search)
    where('english_name like ?', ['%', txt_search.try(:strip), '%'].join)
  end

  def total_cases
    covid_information.sum(:new_cases).to_i + total_death_cases.to_i + total_recovered_cases.to_i
  end

  def total_active_cases
    total_cases.to_i - (total_death_cases.to_i + total_recovered_cases.to_i)
  end

  def total_death_cases
    covid_information.sum(:new_deaths)
  end

  def total_recovered_cases
    covid_information.last.try(:recovered)
  end

  def new_cases
    covid_information.find_by(date_event: Date.current).try(:new_cases).try(:to_i)
  end

end
