class AddForeignKeyAppAddress < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :addresses, :applications
  end
end
