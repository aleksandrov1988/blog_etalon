class AddColorToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :color, :string
    add_column :users, :bg_color, :string
    add_column :users, :a_color, :string
  end
end
