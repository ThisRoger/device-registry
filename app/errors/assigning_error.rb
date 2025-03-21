module AssigningError
  class AlreadyUsedOnOtherUser < StandardError
    def initialize(message = "Device is already assigned to another user.")
      super(message)
    end
  end

  class AlreadyUsedOnUser < StandardError
    def initialize(message = "Device is already assigned to another user.")
      super(message)
    end
  end
end
