class CreateSolutions < ActiveRecord::Migration[6.1]
  def change
    create_table :solutions do |t|
      t.string :type
      t.string :title
      t.string :description
      t.string :schedule
      t.string :image
      t.string :where
      t.timestamps
    end
  end
end
