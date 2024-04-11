module TestData
  module_function

  def image_data
    attacher = Shrine::Attacher.new
    attacher.set(uploaded_image)

    attacher.column_data
  end

  def uploaded_image
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