class CookieChannel < ApplicationCable::Channel
  def subscribed
    cookie = find_cookie(params[:cookie_id])
    stream_from "cookie_#{cookie.id}" if cookie.present?
  end

  def self.broadcast_ready(cookie)
    ActionCable.server.broadcast("cookie_#{cookie.id}", ready: true)
  end

  private

  def find_cookie(cookie_id)
    user_cookies = Cookie.where(storage: self.current_user.ovens)
                         .or(Cookie.where(storage: self.current_user))
    user_cookies.find_by(id: cookie_id)
  end
end