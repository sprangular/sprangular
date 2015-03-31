module Sprangular::AddressDecorator
  def self.prepended(klass)
    klass.belongs_to :user, class_name: 'Spree::User'
  end

  def same_as?(other)
    return false if other.nil?
    attributes.except('id', 'updated_at', 'created_at', 'user_id') == other.attributes.except('id', 'updated_at', 'created_at', 'user_id')
  end
end

Spree::Address.send(:prepend, Sprangular::AddressDecorator)
