class OvensController < ApplicationController
  before_action :authenticate_user!

  def index
    @ovens = current_user.ovens
  end

  def show
    @oven = current_user.ovens.find_by!(id: params[:id])
  end

  def empty
    @oven = current_user.ovens.find_by!(id: params[:id])
    if @oven.cookie
      @oven.cookie.update_attributes!(storage: current_user)
    end
    if @oven.sheet
      @oven.sheet.cookies.each do |cookie|
        cookie.update_attributes!(storage: current_user)
      end
      @oven.sheet.destroy
    end
    redirect_to @oven, alert: 'Oven emptied!'
  end
end
