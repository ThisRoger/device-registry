module AssigningError
  class AlreadyUsedOnOtherUser < StandardError
    def initialize(message = "Device is already assigned to another user.")
      super(message)
    end
  end

  class AlreadyUsedOnCurrentUser < StandardError
    def initialize(message = "Device is already assigned to this user.")
      super(message)
    end
  end
end
