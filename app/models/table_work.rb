class TableWork < ActiveRecord::Base
  belongs_to :work_schema
  has_many :colum_in_table_works

  auto_strip_attributes :register_in_data_base


  accepts_nested_attributes_for :colum_in_table_works, :reject_if => :all_blank, :allow_destroy => true

end
