class AddLegendToReportDinamicView < ActiveRecord::Migration
  def change
    add_column :report_dinamic_views, :legend, :text
  end
end
