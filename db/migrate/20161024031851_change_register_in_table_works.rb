class ChangeRegisterInTableWorks < ActiveRecord::Migration
  def change
    change_column :register_in_colum_table_works, :value_string, :text, :limit => 4294967295
  end
end
