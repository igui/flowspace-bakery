class CookiesController < ApplicationController
  before_action :authenticate_user!

  def new
    @oven = current_user.ovens.find_by!(id: params[:oven_id])
    if @oven.cookie || @oven.sheet
      redirect_to @oven, alert: "There's something is already in the oven!"
    else
      @cookie = @oven.build_cookie
    end
  end

  def create
    @oven = current_user.ovens.find_by!(id: params[:oven_id])
    if cookie_params[:fillings].blank?
      redirect_to new_oven_cookies_path(@oven), alert: 'No fillings!'
    else
      @cookie = @oven.create_cookie(cookie_params)
      unless @cookie.valid?
        redirect_to new_oven_cookies_path(@oven), alert: "Can't create cookie"
      else
        # Bake the cookie in some seconds
        ::CookieBakerWorker.perform_in(Random.rand(5..20).seconds, @cookie.id)
        
        redirect_to oven_path(@oven)
      end
    end
  end

  private

  def cookie_params
    params.require(:cookie).permit(:fillings)
  end
end
