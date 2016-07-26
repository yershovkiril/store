class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    name = [version_name, "default.png"].compact.join('_')
    ActionController::Base.helpers.asset_path("fallback/" + name)
  end

  # Process files as they are uploaded:
  process :resize_to_fill => [170, 230]

  # Create different versions of your uploaded files:
  version :thumb do
    process :resize_to_fit => [160, 160]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
