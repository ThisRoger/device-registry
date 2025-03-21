# frozen_string_literal: true

class AssignDeviceToUser
  def initialize(requesting_user:, serial_number:, new_device_owner_id:)
  end

  def call(requesting_user:, device_serial_number:)
    unless requesting_user.is_a?(User)
      puts "User with ID #{requesting_user.id} wasn't found!"
      return
    end

    if requesting_user.is_renting?
      puts "User with ID #{requesting_user.id} is already renting a device!"
      return
    end

    found_device = Device.find_by(serial_number: device_serial_number)

    unless found_device
      puts "Device with serial number #{device_serial_number} was not found!"
      return
    end

    if found_device.is_rented?
      puts "Device with serial number #{device_serial_number} is already rented by another user!"
      return
    end

    if found_device.users_ids.include?(requesting_user.id.to_s)
      puts "User with ID #{requesting_user.id} already had rented the device with serial number #{device_serial_number}!"
      return
    end

    requesting_user.update(is_renting: device_serial_number)
    found_device.update(renting_user_id: requesting_user.id)
    found_device.users_ids << requesting_user.id
    found_device.save!
    true
  end
end
