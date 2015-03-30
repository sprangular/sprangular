module Sprangular::AddressDecorator
  def self.prepended(klass)
    klass.belongs_to :user, class_name: 'Spree::User'
  end
end

Spree::Address.send(:prepend, Sprangular::AddressDecorator)
