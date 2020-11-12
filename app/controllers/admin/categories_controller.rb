class Admin::CategoriesController < ApplicationController


  def index
    @categories = Category.order(:name)
  end

  def new
    @category = Category.new
  end

end
