require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    #validation tests/examples here
    it 'should save succesfully' do
      @category = Category.new(name: 'Mega Category')
      @product = Product.new(name: 'Megaman', price_cents:  500, quantity: 10, category: @category)
      @product.save!
      expect(@product.id).to be_present
    end

    it 'should validate that name is present' do
      @category = Category.new(name: 'Mega Category')
      @product = Product.new(name: nil, price_cents:  500, quantity: 10, category: @category)
      @product.save
      expect(@product.errors.full_messages).to contain_exactly("Name can't be blank")
    end

    it 'should validate that price is present' do
      @category = Category.new(name: 'Mega Category')
      @product = Product.new(name: 'Megaman', price_cents:  nil, quantity: 10, category: @category)
      @product.save
      expect(@product.errors.full_messages).to contain_exactly("Price can't be blank", "Price cents is not a number", "Price is not a number")
    end

    it 'should validate that quantity is present' do
      @category = Category.new(name: 'Mega Category')
      @product = Product.new(name: 'Megaman', price_cents:  500, quantity: nil, category: @category)
      @product.save
      expect(@product.errors.full_messages).to contain_exactly("Quantity can't be blank")
    end

    it 'should validate that category is present' do
      @product = Product.new(name: 'Megaman', price_cents:  500, quantity: 10, category: nil)
      @product.save
      expect(@product.errors.full_messages).to contain_exactly("Category can't be blank")
    end


  end
end
