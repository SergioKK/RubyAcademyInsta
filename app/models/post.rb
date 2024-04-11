class Post < ApplicationRecord
  include ImageUploader::Attachment(:image)

  validates :title, presence: true
  validates :image, presence: true

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  scope :followers, ->(following) { where user_id: following }
end
