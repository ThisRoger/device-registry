class User < ApplicationRecord
  has_many :api_keys, as: :bearer
  has_many :devices, foreign_key: :renting_user_id
  has_secure_password

  def is_renting?
      rented_device_serial_number?
  end
end
