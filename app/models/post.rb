class Post < ApplicationRecord
  include ImageUploader::Attachment(:image)

  validates :title, presence: true

  belongs_to :user
  has_many :comments
  has_many :likes, dependent: :destroy
end
