# frozen_string_literal: true

class AssignDeviceToUser
  def initialize(requesting_user:, serial_number:, new_device_owner_id:)
    @requesting_user = requesting_user
    @serial_number = serial_number
    @new_device_owner_id = new_device_owner_id
  end

  def call
    unless @requesting_user.is_a?(User)
      puts "User with ID #{@requesting_user.id} wasn't found!"
      return
    end


    if @requesting_user.is_renting?
      puts "User with ID #{@requesting_user.id} is already renting a device!"
      raise AssigningError::AlreadyUsedOnOtherUser
    end

    found_device = Device.find_by(serial_number: @serial_number)

    unless found_device
      puts "Device with serial number #{@serial_number} was not found!"
      raise RegistrationError::Unauthorized
    end

    if found_device.is_rented?
      puts "Device with serial number #{@serial_number} is already rented by another user!"
      raise RegistrationError::Unauthorized
    end

    rental_history = DeviceRental.find_by(device_serial_number: found_device.serial_number)

    if rental_history.nil?
      DeviceRental.create(
        :rental_date => Time.now,
        :device_serial_number => @serial_number,
        :user_id => @requesting_user.id
      )
      found_device.update(renting_user_id: @requesting_user.id)
      nil
    else
      if rental_history.user_id != @requesting_user.id
        raise AssigningError::AlreadyUsedOnOtherUser
      end
      if rental_history.user_id == @requesting_user.id and rental_history.return_date.nil?
        puts "Device with serial number #{@serial_number} was already rented by this user!"
        raise RegistrationError::Unauthorized
      end
      if rental_history.user_id == @requesting_user.id
        puts "Device with serial number #{@serial_number} is currently rented by this user!"
        raise RegistrationError::Unauthorized
      end
    end
  end
end
