class AddCurrentRentingUserIdToDevices < ActiveRecord::Migration[7.1]
  def change
    add_column :devices, :renting_user_id, :text
  end
end
