class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, -> { ordering }, dependent: :destroy

  scope :ordering, -> { order(created_at: :desc) }
  scope :full, -> { includes(:user) }

  validates :title, presence: true, length: {in: 3..140}
  validates :body, presence: true, length: {minimum: 3}
  validate :check_user

  def edit_by?(current_user)
    user == current_user || current_user&.admin?
  end

  def human
    "#{self.class.model_name.human} №#{id}"
  end

  private

  def check_user
    if new_record? && Post.where('user_id = ? and created_at > ?', user_id, 1.day.ago).count >= 5
      errors.add(:base, 'Превышен лимит на мксимальное количество сообщений за сутки')
    end
  end
end
