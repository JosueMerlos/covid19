class DailyInformation < ApplicationRecord

  belongs_to :country
  scope :by_date, ->(date) { where(date_event: date) }

end
