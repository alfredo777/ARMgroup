class AddNameToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :name, :string
    add_column :customers, :submname, :string
    add_column :customers, :route_files, :string
    add_column :customers, :empresa, :string
    add_column :customers, :idempresa, :string
  end
end
