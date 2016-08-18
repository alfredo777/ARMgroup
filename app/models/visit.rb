class Visit < ActiveRecord::Base
  has_many :ahoy_events, class_name: "Ahoy::Event"
  belongs_to :admin, class_name: "Admin"
  belongs_to :customer, class_name: "Customer"
end
