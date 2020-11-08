class CookieBakerWorker 
  include Sidekiq::Worker

  def perform(cookie_id)
    cookie = Cookie.find_by(id: cookie_id)
    return unless cookie

    cookie.update!(ready: true)
  end
end
