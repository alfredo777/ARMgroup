class ColumInTableWork < ActiveRecord::Base
  belongs_to :table_work
  has_many :register_in_colum_table_works
  

  auto_strip_attributes :register_in_data_base

  def head_ahead
   head = self.register_in_data_base.gsub('"', "")
   @head = head
  end

end
