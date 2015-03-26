class AddUserIdToSpreeAddresses < ActiveRecord::Migration
  def change
    add_reference :spree_addresses, :spree_user
  end
end
