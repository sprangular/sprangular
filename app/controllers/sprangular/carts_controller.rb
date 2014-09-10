class Sprangular::CartsController < Sprangular::BaseController

  def show
    @order = current_order
    if @order
      render 'show'
    else
      not_found
    end
  end

  # Adds a new item to the order (creating a new order if none already exists)
  def add_variant
    populator = Spree::OrderPopulator.new(current_order(create_order_if_necessary: true), current_currency)
    if populator.populate(params[:variant_id], params[:quantity])
      current_order.ensure_updated_shipments
      @order = current_order
      render 'show'
    else
      invalid_resource!(populator)
    end
  end

  def update_variant
    variant_id = params[:variant_id].to_i

    @order = current_order(create_order_if_necessary: true)

    line_item = @order.line_items.detect { |li| li.variant_id == variant_id }
    data = {
      variant_id: variant_id,
      quantity: params[:quantity]
    }
    data.merge!(id: line_item.id) if line_item
    @order.contents.update_cart(line_items_attributes: { '0' => data })

    render 'show'
  end

  def destroy
    if @order = current_order
      @order.empty!
      @order.state ='cart'
      @order.save!
      render 'show'
    else
      not_found
    end
  end

end
