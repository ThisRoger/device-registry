class Device < ApplicationRecord
  belongs_to :user, foreign_key: :renting_user_id, optional: true

  def is_rented?
    if renting_user_id?
      user_id?
    end
  end
end
