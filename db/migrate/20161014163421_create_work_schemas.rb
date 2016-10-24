class CreateWorkSchemas < ActiveRecord::Migration
  def change
    create_table :work_schemas do |t|
      t.string :name
      t.integer :customer_id
      t.integer :campaing_id

      t.timestamps null: false
    end

    add_index :work_schemas, :customer_id
    add_index :work_schemas, :campaing_id
  end
end
