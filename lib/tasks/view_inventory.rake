desc "view inventory"

task :view_inventory => [:environment] do
  Product.view_inventory
end
