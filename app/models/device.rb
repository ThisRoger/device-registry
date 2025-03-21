class Device < ApplicationRecord

  def is_rented?
    if renting_user_id?
      true
    else
      false
    end
  end
end
