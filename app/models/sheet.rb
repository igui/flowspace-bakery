class Sheet < ActiveRecord::Base
  belongs_to :user
  belongs_to :oven
  has_many :cookies, as: :storage
  validates :user, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 1, less_then_or_equal_to: 50 }, presence: true
end
