class Meal < ApplicationRecord
  belongs_to :user
  belongs_to :product

  def to_datetime=(date)
    self.created_at = Time.at(date.to_i).to_datetime
  end
end
