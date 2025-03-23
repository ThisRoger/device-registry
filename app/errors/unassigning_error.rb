module UnassigningError
  class OwnedByAnotherUser < StandardError
    def initialize(message = "You are cannot unassign a device from another user!.")
      super(message)
    end
  end

  class DeviceNotRented < StandardError
    def initialize(message = "Device hasn't been rented by this user!")
      super(message)
    end
  end

  class DeviceWasAlreadyRentedByThisUser < StandardError
    def initialize(message = "You cannot reassign a device you've already rented!.")
      super(message)
    end
  end

  class AlreadyUsedOnOtherUser < StandardError
    def initialize(message = "Device is currently rented by another user")
      super(message)
    end
  end
end