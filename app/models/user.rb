class User < ApplicationRecord
  has_secure_password

  has_many :posts, -> { ordering }, dependent: :destroy
  has_many :comments, -> { ordering }, dependent: :destroy
  has_many :likes, -> { ordering }, dependent: :destroy

  validates :name, length: {in: 2..100}
  validates :login, presence: true, length: {in: 2..100}, uniqueness: {case_sensetive: false}

  scope :ordering, -> { order(:login) }

  def edit_by?(current_user)
    self == current_user || current_user&.admin?
  end
end
