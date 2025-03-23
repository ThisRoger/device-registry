# frozen_string_literal: true

class AssignDeviceToUser
  def initialize(requesting_user:, serial_number:, new_device_owner_id:)
    @requesting_user = requesting_user
    @serial_number = serial_number
    @new_device_owner_id = new_device_owner_id
  end

  def validate_requesting_user_permissions
    if @new_device_owner_id.nil?
      @new_device_owner_id = @requesting_user.id
    end

    if @requesting_user.id.to_s != @new_device_owner_id.to_s
      Rails.logger.error "You cannot assign a device to another user!"
      raise RegistrationError::Unauthorized
    end

    if @requesting_user.is_renting?
      Rails.logger.error "User with ID #{@requesting_user.id} is already renting a device!"
      raise AssigningError::AlreadyUsedOnCurrentUser
    end
  end

  def create_rental_entry_and_update_entities(found_device)
    # the line below ensured the method is fully atomic
    ActiveRecord::Base.transaction do
      DeviceRental.create!(
        :rental_date => DateTime.now,
        :device_serial_number => @serial_number,
        :user_id => @requesting_user.id
      )
      found_device.update(renting_user_id: @requesting_user.id)
      @requesting_user.update(rented_device_serial_number: @serial_number)
    end
    Rails.logger.info "Device rented successfully!"
  end

  def call
    validate_requesting_user_permissions
    found_device = Device.find_or_create_by(serial_number: @serial_number)

    if found_device.is_rented?
      Rails.logger.error "Device with serial number #{@serial_number} is already rented by another user!"
      raise AssigningError::AlreadyUsedOnOtherUser
    end

    rental_history = DeviceRental.find_by(device_serial_number: @serial_number, user_id: @requesting_user.id)

    if rental_history.nil?
      create_rental_entry_and_update_entities(found_device)
      true
    else
      Rails.logger.error "Device with serial number #{@serial_number} was already rented by this user!"
      raise AssigningError::AlreadyUsedOnCurrentUser
    end
  end
end

