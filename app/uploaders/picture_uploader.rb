class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  process resize_to_limit: [Settings.image.resize_width_limit, Settings.image.resize_height_limit]
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def default_url(*args)
    "/images/fallback/" + [version_name, "default.jpg"].compact.join("_")
  end

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end
end
