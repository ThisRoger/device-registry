class User < ApplicationRecord
  has_many :api_keys, as: :bearer
  has_secure_password
  belongs_to :rented_device, class_name: 'Device', foreign_key: 'rented_device_serial_number'

  def is_renting?
    if rented_device_serial_number?
      true
    else
      false
    end
  end
end
