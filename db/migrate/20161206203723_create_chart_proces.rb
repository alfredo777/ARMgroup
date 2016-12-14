class CreateChartProces < ActiveRecord::Migration
  def change
    create_table :chart_proces do |t|
      t.text :text_scrip
      t.integer :report_dinamic_view_id

      t.timestamps null: false
    end
  end
end
