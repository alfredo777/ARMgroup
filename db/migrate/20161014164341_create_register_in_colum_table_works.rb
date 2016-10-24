class CreateRegisterInColumTableWorks < ActiveRecord::Migration
  def change
    create_table :register_in_colum_table_works do |t|
      t.string :value_string
      t.float :value_numeric_no_integer
      t.integer :value_integer
      t.integer :colum_in_table_work_id

      t.timestamps null: false
    end
    add_index :register_in_colum_table_works, :colum_in_table_work_id
  end
end
