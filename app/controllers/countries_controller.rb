class CountriesController < ApplicationController
  def index
    @countries = Country.search(params[:search])
                        .or(Country.search('Global'))
                        .includes(:covid_information)
  end
end
