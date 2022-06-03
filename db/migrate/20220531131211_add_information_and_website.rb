class AddInformationAndWebsite < ActiveRecord::Migration[6.1]
  def change
    add_column :solutions, :website, :string
    add_column :solutions, :information, :string
  end
end
