class Notice < ActiveRecord::Base
  belongs_to :owner, :polymorphic => true
  belongs_to :admin
  belongs_to :customer
  
end
