class Oven < ActiveRecord::Base
  belongs_to :user
  has_one :cookie, as: :storage
  has_one :sheet

  validates :user, presence: true
end
