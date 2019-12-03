class AddInfoToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :birthday, :date
    add_column :users, :male, :boolean
    add_column :users, :birthcity, :string
    add_column :users, :hobby, :text
  end
end
