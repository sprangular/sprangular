class Sprangular.Adjustment
  init: ->
    @amount = Number(@amount)

  isPromo: ->
    @source_type == 'Spree::PromotionAction'

  # label == 'Promotion (couponName)'
  promoCode: ->
    @label.split(/[()]+/)[1]
