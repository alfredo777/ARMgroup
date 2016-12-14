class AddTypeChartToReportDinamicView < ActiveRecord::Migration
  def change
    add_column :report_dinamic_views, :type_chart, :string
  end
end
