class CreateRequestBaseToReports < ActiveRecord::Migration
  def change
    create_table :request_base_to_reports do |t|
      t.text :base_in_text

      t.timestamps null: false
    end
  end
end
