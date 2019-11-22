class User < ApplicationRecord
  has_secure_password

  has_many :posts, -> { ordering }, dependent: :destroy
  has_many :comments, -> { ordering }, dependent: :destroy

  validates :name, length: {in: 2..100}
  validates :login, presence: true, length: {in: 2..100}, uniqueness: {case_sensetive: false}
  validates :color, format: {with: /\A#[0-9a-f]{6}\z/i}, allow_blank: true
  validates :a_color, format: {with: /\A#[0-9a-f]{6}\z/i}, allow_blank: true
  validates :bg_color, format: {with: /\A#[0-9a-f]{6}\z/i}, allow_blank: true

  scope :ordering, -> { order(:login) }

  def edit_by?(current_user)
    self == current_user || current_user&.admin?
  end
end
