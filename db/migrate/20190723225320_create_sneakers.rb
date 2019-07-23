class CreateSneakers < ActiveRecord::Migration
  def change
    create_table :sneakers do |t|
      t.string :context
      t.integer :number
      t.integer :user_id
    end
  end
end
