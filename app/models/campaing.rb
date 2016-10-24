class Campaing < ActiveRecord::Base
  belongs_to :customer
  belongs_to :admin
  has_many :work_schemas
end
