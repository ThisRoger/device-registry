class AddCurrentlyRentedDeviceSerialNumberToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :rented_device_serial_number, :text
  end
end
