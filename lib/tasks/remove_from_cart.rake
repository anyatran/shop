desc "remove from cart"

task :remove_from_cart, [:user_id, :product_id, :quantity] => [:environment] do |task, args|
  user_id = args.user_id or fail "user id should be supplied"
  product_id = args.product_id or fail "product id should be supplied"
  quantity = args.quantity or fail "quantity should be supplied"
  unless quantity && quantity.to_i > 0
    fail "Quantity cannot be less than 1"
  end
  Cart.remove_from_cart(user_id, product_id, quantity)
end
