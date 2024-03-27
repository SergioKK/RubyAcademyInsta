require "image_processing/mini_magick"
class ImageUploader < Shrine
  include ImageProcessing::MiniMagick
  Attacher.validate do
  #   validate_size      1*1024*1024
    validate_mime_type %w[image/jpeg image/png image/webp image/tiff]
  end
end