module RegistrationError
  class Unauthorized < StandardError
    def initialize(message = "You are not authorized to perform this action.")
      super(message)
    end
  end
end
