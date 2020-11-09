class CreateSheets < ActiveRecord::Migration[5.1]
  def change
    create_table :sheets do |t|
      t.boolean :ready, :boolean, null: false, default: false
      t.integer :quantity, :boolean, null: false, default: false
      t.string  :fillings, :boolean, null: false, default: false
      t.references :user, index: true
      t.references :oven, index: true
      t.timestamps
    end
  end
end
