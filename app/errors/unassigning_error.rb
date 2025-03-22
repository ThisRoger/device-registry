module UnassigningError
  class OwnedByAnotherUser < StandardError
    def initialize(message = "You are not authorized to perform this action.")
      super(message)
    end
  end

  class DeviceNotRented < StandardError
    def initialize(message = "Device hasn't been rented by this user.")
      super(message)
    end
  end

end