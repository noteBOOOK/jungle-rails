class Admin::DashboardController < Admin::BaseController
  def show
    @products = Product.all
    @categories = Category.all
  end
end
