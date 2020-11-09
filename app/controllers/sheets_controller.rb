class SheetsController < ApplicationController
  before_action :authenticate_user!

  def new
    @oven = current_user.ovens.find_by!(id: params[:oven_id])
    if @oven.cookie || @oven.sheet
      redirect_to @oven, alert: "There's something is already in the oven!"
    else
      @sheet = @oven.build_sheet(user: current_user)
    end
  end

  def create
    @oven = current_user.ovens.find_by!(id: params[:oven_id])
    if sheet_params[:fillings].blank?
      redirect_to new_oven_sheets_path(@oven), alert: 'No fillings!'
    elsif sheet_params[:quantity].blank? || [1..50].include?(sheet_params[:quantity].to_i)
      redirect_to new_oven_sheets_path(@oven), alert: 'Invalid Quantity'
    else
      @sheet = @oven.create_sheet(sheet_params.merge(user: current_user))
      unless @sheet.valid?
        redirect_to new_oven_sheets_path(@oven), alert: "Can't create sheet"
      else
        @sheet.quantity.times do 
          Cookie.create!(storage: @sheet, fillings: @sheet.fillings)
        end

        # Bake the cookies in the sheet in some seconds
        ::SheetBakerWorker.perform_in(Random.rand(5..20).seconds, @sheet.id)
        
        redirect_to oven_path(@oven)
      end
    end
  end

  private

  def sheet_params
    params.require(:sheet).permit(:fillings, :quantity)
  end
end
