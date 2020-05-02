class Api::V1::CountriesController < ApplicationController

  def index
    @countries = Country.all.includes(:covid_information, :daily_information)
    render 'index.json'
  end

  def show
    @countries = Country.search(params[:id])
                        .or(Country.search('Global'))
                        .includes(:covid_information, :daily_information)
    render 'index.json'
  end

end
