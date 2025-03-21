class Device < ApplicationRecord
  serialize :users_ids, Array
  belongs_to :renting_user, class_name: 'User', foreign_key: 'renting_user_id'
end
