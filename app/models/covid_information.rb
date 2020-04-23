class CovidInformation < ApplicationRecord
  belongs_to :country

  def self.total_cases
    total_active_cases.to_i + total_death_cases.to_i + total_recovered_cases.to_i
  end

  def self.total_active_cases
    new_cases.to_i - (total_death_cases.to_i + total_recovered_cases.to_i)
  end

  def self.total_death_cases
    sum(:new_deaths)
  end

  def self.total_recovered_cases
    sum(:recovered)
  end

  def self.new_cases
    sum(:new_cases)
  end
end
