class AddObjective < ActiveRecord::Migration[6.1]
  def change
    add_column :forms, :objective, :string
  end
end
