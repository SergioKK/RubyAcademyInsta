module TestData
  module_function

  def image_data
    attacher = Shrine::Attacher.new
    attacher.set(uploaded_image)

    attacher.column_data
  end

  def uploaded_image
    # due to set mime_type manual, but not from the file we turn off Shrine WARNING
    Shrine.logger.level = Logger::FATAL

    file = File.open("spec/files/image.jpeg", binmode: true)

    # for performance we skip metadata extraction and assign test metadata
    uploaded_file = Shrine.upload(file, :cache, metadata: false)
    uploaded_file.metadata.merge!(
      "size" => File.size(file.path),
      "mime_type" => "image/jpeg",
      "filename" => "image.jpeg",
    )

    uploaded_file
  end
end