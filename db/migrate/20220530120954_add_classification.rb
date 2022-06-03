class AddClassification < ActiveRecord::Migration[6.1]
  def change
    add_column :solutions, :classification, :string
  end
end
