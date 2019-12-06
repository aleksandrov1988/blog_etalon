class Post < ApplicationRecord
  has_paper_trail only: [:body]
  belongs_to :user
  has_many :comments, -> { ordering }, dependent: :destroy

  scope :ordering, -> { order(created_at: :desc) }
  scope :full, -> { includes(:user) }

  validates :title, presence: true, length: {in: 3..140}
  validates :body, presence: true, length: {minimum: 3}

  def edit_by?(current_user)
    user == current_user || current_user&.admin?
  end

  def human
    "#{self.class.model_name.human} №#{id}"
  end
end
