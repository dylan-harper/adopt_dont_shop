class AddAppIdToAddress < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :application_id, :integer
  end
end
