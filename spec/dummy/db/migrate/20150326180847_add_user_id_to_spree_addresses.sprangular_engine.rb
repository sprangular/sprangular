# This migration comes from sprangular_engine (originally 20150326000000)
class AddUserIdToSpreeAddresses < ActiveRecord::Migration
  def change
    add_column :spree_addresses, :user_id, :integer
    add_index  :spree_addresses, :user_id
  end
end
