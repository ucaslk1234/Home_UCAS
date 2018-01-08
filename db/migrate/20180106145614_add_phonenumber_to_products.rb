class AddPhonenumberToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :phonenumber, :string
  end
end
