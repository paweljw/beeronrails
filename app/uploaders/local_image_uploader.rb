# encoding: utf-8

class LocalImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :watermark
  process :resize_to_fit => [850, 700]

  version :thumb do
     process :resize_to_fit => [350, 0]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def watermark
    manipulate! do |img|
      logo = Magick::Image.read("#{Rails.root}/app/assets/images/watermark.png").first
      img = img.composite(logo, Magick::SouthEastGravity, Magick::OverCompositeOp)
    end
  end

end
