class AddNoCommentToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :no_comment, :boolean
  end
end
