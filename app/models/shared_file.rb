class SharedFile < ActiveRecord::Base
  belongs_to :fileable, :polymorphic => true
  mount_uploader :url, ShareFileUploader
end
