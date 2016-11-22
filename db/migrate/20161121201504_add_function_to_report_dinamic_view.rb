class AddFunctionToReportDinamicView < ActiveRecord::Migration
  def change
    add_column :report_dinamic_views, :function, :boolean, default: false
  end
end
