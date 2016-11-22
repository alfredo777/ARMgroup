class AddWordcloudToTableWork < ActiveRecord::Migration
  def change
    add_column :table_works, :wordcloud, :boolean, default: false
    add_column :table_works, :response_code, :boolean, default: false
    add_column :table_works, :others, :boolean, default: false
    add_column :table_works, :response_codes, :text
    add_column :table_works, :wordcloud_words, :text
  end
end
