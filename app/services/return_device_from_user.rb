# frozen_string_literal: true

class ReturnDeviceFromUser
  def initialize(user:, serial_number:, from_user:)
    @user = user
    @serial_number = serial_number
    @from_user = from_user
  end

  def call
    if @user.id != @from_user
      puts "You cannot return a device from another user!"
      raise AssigningError::AlreadyUsedOnUser
    end

    rental_history = DeviceRental.find_by(device_serial_number: @serial_number, user_id: @user.id)

    if rental_history.nil?
      puts "This user never rented a device with serial number #{@serial_number}!"
      raise UnassigningError::DeviceNotRented
    end

    if rental_history.return_date.nil?
      rented_device = Device.find_by(@serial_number)
      rented_device.update(renting_user_id: nil)
      rented_device.save
      rental_history.return_date = DateTime.now
      rental_history.save
      @user.update(rented_device_serial_number: nil)
      @user.save
    else
      raise UnassigningError::DeviceWasAlreadyRentedByThisUser
    end
  end
end
