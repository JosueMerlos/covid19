class CountriesController < ApplicationController
  def index
    @countries = Country.search(params[:search])
                        .includes(:covid_information)
  end
end
