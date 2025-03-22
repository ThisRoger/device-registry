class DeviceRentals < ActiveRecord::Migration[7.1]
  create_table :device_rentals do |t|
    t.date :rental_date
    t.date :return_date
    t.integer :user_id
    t.integer :device_serial_number
  end
end
