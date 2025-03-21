# frozen_string_literal: true

class AssignDeviceToUser
  def initialize(requesting_user:, serial_number:, new_device_owner_id:)
  end

  def call(requesting_user:, serial_number:)
    if requesting_user.is_a?(User)
      if requesting_user.is_renting?
        puts "User with ID #{requesting_user.id} is already renting a Device!"
        else
        requesting_user.update(is_renting: serial_number)
        puts "User with ID #{requesting_user.id} is now renting the device with serial number: #{serial_number}!"
      end
    else
      puts "User with ID #{requesting_user.id} is not a User!"
    end
  end
end
