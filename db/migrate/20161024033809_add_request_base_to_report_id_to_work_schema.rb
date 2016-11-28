class AddRequestBaseToReportIdToWorkSchema < ActiveRecord::Migration
  def change
    add_column :work_schemas, :request_base_to_report_id, :integer
    add_column :request_base_to_reports, :campaing_id, :integer
  end
    #add_index :work_schemas, :request_base_to_report_id
    add_index :request_base_to_reports, :campaing_id
end
