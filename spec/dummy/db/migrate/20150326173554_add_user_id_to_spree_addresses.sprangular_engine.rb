# This migration comes from sprangular_engine (originally 20150326000000)
class AddUserIdToSpreeAddresses < ActiveRecord::Migration
  def change
    add_reference :spree_addresses, :spree_user
  end
end
