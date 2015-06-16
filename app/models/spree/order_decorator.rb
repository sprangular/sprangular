module Sprangular
  module OrderExtensions
    def line_item_promotion_adjustments
      self.line_item_adjustments.promotion
    end
  end
end

Spree::Order.prepend Sprangular::OrderExtensions
