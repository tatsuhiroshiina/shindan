class AddColumns < ActiveRecord::Migration[6.1]
  def change
    add_column :forms, :industry, :string
    add_column :forms, :series, :string
    add_column :forms, :product_type, :string
    add_column :forms, :region, :string
    add_column :forms, :field, :string
    add_column :forms, :company_type, :string
  end
end
