class DeviceRental < ApplicationRecord

  def self.find_rental_entry(user_id, device_serial_number)
    where(user_id: user_id, device_serial_number: device_serial_number)
  end
end
