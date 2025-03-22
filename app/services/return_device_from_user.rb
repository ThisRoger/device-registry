# frozen_string_literal: true

class ReturnDeviceFromUser
  def initialize(user:, serial_number:, from_user:)
    @user = user
    @serial_number = serial_number
    @from_user = from_user
  end

  def validate_requesting_user_permissions
    if @from_user.nil?
      @from_user = @user.id
    else
      if @user.id != @from_user
        Rails.logger.error "You cannot return a device from another user!"
        raise UnassigningError::AlreadyUsedOnOtherUser
      end
    end
  end

  def unassign_device_from_current_owner(rental_history)
    ActiveRecord::Base.transaction do
      rented_device = Device.find_by(serial_number: @serial_number)
      rented_device.update!(renting_user_id: nil)
      rental_history.update!(return_date: DateTime.now)
      @user.update!(rented_device_serial_number: nil)
    end
    Rails.logger.info "Device returned successfully!"
  end

  def call
    validate_requesting_user_permissions
    rental_history = DeviceRental.find_by(device_serial_number: @serial_number, user_id: @user.id)

    if rental_history.nil?
      Rails.logger.error "This user never rented a device with serial number #{@serial_number}!"
      raise UnassigningError::DeviceNotRented
    end

    if rental_history.return_date.nil?
      unassign_device_from_current_owner(rental_history)
    else
      Rails.logger.error "This user already had rented this device previously!"
      raise UnassigningError::DeviceWasAlreadyRentedByThisUser
    end
  end
end
