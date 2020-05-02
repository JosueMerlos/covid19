class WakeUpJob < ApplicationJob
  queue_as :default

  def perform
    require 'open-uri'
    puts 'wake up!!!!'
    open('https://covid20-info.herokuapp.com/countries/index')
  end
end
