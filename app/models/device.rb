class Device < ApplicationRecord
  serialize :users_ids, Array
  belongs_to :renting_user, class_name: 'User', foreign_key: 'renting_user_id'

  def is_rented?
    if renting_user_id?
      true
    else
      false
    end
  end
end
