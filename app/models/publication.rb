class Publication < ActiveRecord::Base
  belongs_to :admin

  mount_uploader :head_image, HeadImageUploader
end
