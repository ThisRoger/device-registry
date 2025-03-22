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
      return false
    end

    if @requesting_user.id != @new_device_owner_id
      puts "You cannot assign a device to another user!"
      raise RegistrationError::Unauthorized
    end

    if @requesting_user.is_renting?
      puts "User with ID #{@requesting_user.id} is already renting a device!"
      raise AssigningError::AlreadyUsedOnOtherUser
    end

    found_device = Device.find_or_create_by(serial_number: @serial_number)

    unless found_device
      puts "Device with serial number #{@serial_number} was not found!"
      raise RegistrationError::Unauthorized
    end

    if found_device.is_rented?
      puts "Device with serial number #{@serial_number} is already rented by another user!"
      raise AssigningError::AlreadyUsedOnOtherUser
    end

    rental_history = DeviceRental.find_by(device_serial_number: @serial_number, user_id: @requesting_user.id)

    if rental_history.nil?
      created_entry = DeviceRental.create(
        :rental_date => DateTime.now,
        :device_serial_number => @serial_number,
        :user_id => @requesting_user.id
      )
      created_entry.save
      found_device.update(renting_user_id: @requesting_user.id)
      found_device.save
      true
    else
      if rental_history.user_id == @requesting_user.id and rental_history.return_date != nil
        puts "Device with serial number #{@serial_number} was already rented by this user!"
        raise AssigningError::AlreadyUsedOnUser
      end
      if rental_history.user_id == @requesting_user.id
        puts "Device with serial number #{@serial_number} is currently rented by this user!"
        puts "About to raise the error!"
        raise AssigningError::AlreadyUsedOnUser
      end
    end
  end
end

