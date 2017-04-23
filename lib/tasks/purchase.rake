desc "purchase"

task :purchase, [:user_id] => [:environment] do |task, args|
  user_id = args.user_id or fail "user id should be supplied"
  Cart.purchase(user_id)
end
