class WorkSchema < ActiveRecord::Base
  has_many :table_works
  belongs_to :customer
  belongs_to :campaing
  belongs_to :request_base_to_report

  accepts_nested_attributes_for :table_works, :reject_if => :all_blank, :allow_destroy => true

end
