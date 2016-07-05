# encoding: utf-8

class HeadImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  process resize_to_fill: [1140, 552]
  process convert: 'png'
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end


  def extension_whitelist
      %w(jpg jpeg gif png)
  end

end
