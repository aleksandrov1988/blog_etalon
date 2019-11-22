class User < ApplicationRecord
  has_secure_password

  has_many :posts, -> { ordering }, dependent: :destroy
  has_many :comments, -> { ordering }, dependent: :destroy

  validates :name, length: {in: 2..100}
  validates :login, presence: true, length: {in: 2..100}, uniqueness: {case_sensetive: false}
  validates :password, length: {minimum: 6}, if: :should_validate_password?
  validate :check_password

  scope :ordering, -> { order(:login) }

  def edit_by?(current_user)
    self == current_user || current_user&.admin?
  end

  def should_validate_password?
    new_record? || password_changed?
  end

  private

  def check_password
    return unless should_validate_password?
    errors.add(:password, 'должен содержать цифру') if password !~ /\d/
    errors.add(:password, 'должен содержать строчную латинскую буквы') if password !~ /[a-z]/
    errors.add(:password, 'должен содержать прописную латинскую буквы') if password !~ /[A-Z]/
  end
end
