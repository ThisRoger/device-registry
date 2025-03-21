class CreateDeviceRentals < ActiveRecord::Migration[7.1]
  def change
    create_table :device_rentals do |t|

      t.timestamps
    end
  end
end
