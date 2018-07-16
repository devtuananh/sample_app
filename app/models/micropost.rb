class Micropost < ApplicationRecord
  belongs_to :user
  mount_uploader :picture, PictureUploader
  scope :by_newest, -> { order(created_at: :desc) }
  default_scope {by_newest}
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.content_maximum}
  validate :picture_size

  private

  def picture_size
    if picture.size > Settings.picture.size.megabytes
      errors.add :picture, I18n.t(".picture_too_large_size",
        size: Settings.picture.size)
    end
  end
end
