class ChangeColumnToNull < ActiveRecord::Migration[6.0]
  def up
    change_column :users, :twitter_url,:string, null: true # null: trueを明示する必要がある
  end

  def down
    change_column :users, :twitter_url,:string, null: false
  end
end
