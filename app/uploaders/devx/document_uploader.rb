# encoding: utf-8

class DocumentUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

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
    # end
  end

  def id_partitioning
    ("%09d" % model.id).scan(/.{3}/).join("/")
  end

  protected

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end
end
