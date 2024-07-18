class AddDetailsToPolicies < ActiveRecord::Migration[7.1]
  def change
    add_column :policies, :payment_id, :string
    add_column :policies, :payment_link, :string
    add_column :policies, :payment_status, :integer, default: 0
  end
end
