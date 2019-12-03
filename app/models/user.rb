class User < ApplicationRecord
  has_secure_password

  has_many :posts, -> { ordering }, dependent: :destroy
  has_many :comments, -> { ordering }, dependent: :destroy

  validates :name, length: {in: 2..100}
  validates :login, presence: true, length: {in: 2..100}, uniqueness: {case_sensetive: false}
  validates :birthcity, length: {maximum: 200}
  validates :hobby, length: {maximum: 1400}
  validate :check_birthday

  scope :ordering, -> { order(:login) }

  def edit_by?(current_user)
    self == current_user || current_user&.admin?
  end

  private

  def check_birthday
    return unless birthday
    min_years = 3
    max_years = 150
    if birthday + min_years.years > Date.today
      errors.add(:birthday, "должна быть более #{min_years} лет назад")
    elsif birthday < max_years.years.ago
      errors.add(:birthday, "должна быть более #{max_years} лет назад")
    end
  end
end
