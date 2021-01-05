class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.text :message
      t.integer :post_id
      t.timestamps
    end
  end
end
