class SheetBakerWorker 
  include Sidekiq::Worker

  def perform(sheet_id)
    sheet = Sheet.find_by(id: sheet_id)
    return unless sheet

    sheet.cookies.each do |c|
      c.update!(ready: true)
    end
    sheet.update!(ready: true)
  end
end
