class ChangeColumnInRequestBaseToReport < ActiveRecord::Migration
  def change
    change_column :request_base_to_reports, :base_in_text, :text, :limit => 4294967295
    add_column :request_base_to_reports, :csv_adress, :string
  end
  
end
