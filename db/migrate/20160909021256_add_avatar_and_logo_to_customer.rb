class AddAvatarAndLogoToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :avatar, :string
    add_column :customers, :logo, :string
  end
end
