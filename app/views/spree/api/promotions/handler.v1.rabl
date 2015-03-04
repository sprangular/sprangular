object false
node(:success) { @handler.success }
node(:error) { @handler.error }
node(:successful) { @handler.successful? }
node(:status_code) { @handler.status_code }

child @order do
  extends "/spree/api/orders/show"
end
