class CountriesController < ApplicationController
  def index
    @countries = Country.search(params[:search]).order(:spanish_name).includes(:covid_information)
    @global_info = {
      total_cases: CovidInformation.total_cases,
      total_active_cases: CovidInformation.total_active_cases,
      total_death_cases: CovidInformation.total_death_cases,
      total_recovered_cases: CovidInformation.total_recovered_cases
    }
  end
end
