class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  scope :ordering, -> { order(:created_at) }
  validates :body, presence: true, length: {minimum: 3}

  def edit_by?(current_user)
    current_user&.admin?
  end
end
