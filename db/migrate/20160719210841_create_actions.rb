class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.string :action
      t.string :time_in_come
      t.integer :customer_id
    end
    add_index :actions, :customer_id
  end
end
