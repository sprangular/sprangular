class Sprangular.Adjustment
  isPromo: ->
    @source_type == 'Spree::PromotionAction'

  # label == 'Promotion (couponName)'
  promoCode: ->
    @label.split(/[()]+/)[1]
