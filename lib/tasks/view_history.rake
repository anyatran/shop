desc "view history"

task :view_history, [:user_id] => [:environment] do |task, args|
  user_id = args.user_id or fail "user id should be supplied"
  History.view_history(user_id)
end
