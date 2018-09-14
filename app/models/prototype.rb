class Prototype < ActiveRecord::Base
  belongs_to :user

  has_many :users, dependent: :destroy, :through => :like

  has_many :comments

  has_many :captured_images, dependent: :destroy
  has_many :likes

  accepts_nested_attributes_for :likes, allow_destroy: :like_user
  accepts_nested_attributes_for :captured_images, reject_if: :reject_sub_images

  validates :title,
            :catch_copy,
            :concept,
            presence: true

  def like_user(user)
   likes.find_by(user_id: user)
  end

  def reject_sub_images(attributed)
    attributed['content'].blank?
  end

  def set_main_thumbnail
    captured_images.main.first.content
  end

  def posted_date
    created_at.strftime('%b %d %a')
  end
end
