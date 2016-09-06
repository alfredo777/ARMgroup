class SharedFile < ActiveRecord::Base
  belongs_to :fileable, :polymorphic => true
  mount_uploader :url, ShareFileUploader

  def file_image
    term = self.name.split('.').last
    puts term
    urlx = "#{Rails.root}/public/icon-files/#{term}.png"
    if File.exist?(urlx)
      @img = "/icon-files/#{term}.png"
    else
      @img = "/icon-files/single.png"
    end
  end
end
