class Device < ApplicationRecord
  belongs_to :user, foreign_key: :renting_user_id, optional: true

  def is_rented?
    renting_user_id?
  end
end
