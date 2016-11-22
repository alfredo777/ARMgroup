class CreateReportDinamicViews < ActiveRecord::Migration
  def change
    create_table :report_dinamic_views do |t|
      t.integer :campaing_id
      t.integer :position
      t.string :function_or_index
      t.text :html_content

      t.timestamps null: false
    end
  end
end
