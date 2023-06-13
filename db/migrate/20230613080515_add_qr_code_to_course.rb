class AddQrCodeToCourse < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :qr_code, :string
  end
end
