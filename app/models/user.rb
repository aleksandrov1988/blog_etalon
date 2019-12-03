class User < ApplicationRecord
  has_secure_password
  has_one_attached :avatar

  has_many :posts, -> { ordering }, dependent: :destroy
  has_many :comments, -> { ordering }, dependent: :destroy

  validates :name, length: {in: 2..100}
  validates :login, presence: true, length: {in: 2..100}, uniqueness: {case_sensetive: false}
  validate :check_avatar

  scope :ordering, -> { order(:login) }

  def edit_by?(current_user)
    self == current_user || current_user&.admin?
  end

  private

  def check_avatar
    if avatar.attached? && !avatar.content_type.start_with?('image/')
      errors.add(:avatar, 'должно быть изображением')
    end
  end
end
