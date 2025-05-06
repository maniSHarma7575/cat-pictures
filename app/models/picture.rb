class Picture < ApplicationRecord
  has_one_attached :attachment
  validates :title, presence: true

  validates :attachment, attached: true, content_type: { in: %w[image/jpeg image/png image/gif image/jpg], message: "must be a valid image format" }
end