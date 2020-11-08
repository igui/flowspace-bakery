class Cookie < ActiveRecord::Base
  belongs_to :storage, polymorphic: :true
  
  validates :storage, presence: true
  validates :fillings, presence: true

  after_save :broadcast_ready

  def broadcast_ready
    CookieChannel.broadcast_ready(self) if saved_change_to_ready? && ready
  end
end
