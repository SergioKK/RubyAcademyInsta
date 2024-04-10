require 'rails_helper'

RSpec.describe ImageUploader do
  let(:image) { photo.image }
  let(:derivatives) { photo.image_derivatives }
  let(:photo) { Photo.create(image: File.open("test/files/image.png", "rb")) }

  it "extracts metadata" do
    expect(image.mime_type).to eq("image/png")
    expect(image.extension).to eq("png")
    expect(image.size).to be_instance_of(Integer)
    expect(image.width).to be_instance_of(Integer)
    expect(image.height).to be_instance_of(Integer)
  end

  it "generates derivatives" do
    expect(derivatives[:small]).to be_kind_of(Shrine::UploadedFile)
    expect(derivatives[:medium]).to be_kind_of(Shrine::UploadedFile)
    expect(derivatives[:large]).to be_kind_of(Shrine::UploadedFile)
  end
end