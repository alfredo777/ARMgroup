class AddOwnerIdAndOwnerTypeToNotice < ActiveRecord::Migration
  def change
    add_column :notices, :owner_id, :integer
    add_column :notices, :owner_type, :string
  end
end
