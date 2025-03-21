class User < ApplicationRecord
  has_many :api_keys, as: :bearer
  has_secure_password
  belongs_to :rented_device, class_name: 'Device', foreign_key: 'rented_device_id'

  def is_renting?
    rented_device_id?
  end
end
