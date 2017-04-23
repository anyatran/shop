desc "view cart"

task :view_cart, [:user_id] => [:environment] do |task, args|
  user_id = args.user_id or fail "user id should be supplied"
  Cart.view_cart(user_id)
end
