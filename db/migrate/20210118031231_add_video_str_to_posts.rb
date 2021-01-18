class AddVideoStrToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :video_str, :string
  end
end
