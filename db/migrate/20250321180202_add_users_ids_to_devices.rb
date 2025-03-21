class AddUsersIdsToDevices < ActiveRecord::Migration[7.1]
  def change
    add_column :devices, :users_ids, :text
  end
end
