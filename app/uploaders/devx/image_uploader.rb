# encoding: utf-8

class Devx::ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{id_partitioning}"
    # if Rails.env.test?
    #   "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{id_partitioning}"
    # else
    #   "#{Rails.env.to_s}/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{id_partitioning}"
    #end
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def id_partitioning
    ("%09d" % model.id).scan(/.{3}/).join("/")
  end

  version :small do
    process :resize_to_fit => [200, 133]
  end
  version :thumbnail do
    process :resize_to_fill => [75, 75]
  end
  version :blog_thumb do
    process :resize_to_fill => [466, 160]
  end
  version :large do
    process :resize_to_fill => [750, 600]
  end
  version :slider do
    process :resize_to_fit => [1900, 450]
  end
  version :profile do
    process :resize_to_fill => [100, 100]
  end

  protected

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end
end
