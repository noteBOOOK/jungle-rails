require 'rails_helper'

RSpec.feature "Visitor can add products to a cart from the home page", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario 'They can add a product to a cart' do
    # ACT
    visit root_path
    save_screenshot 'test_3a.png'

    first('article.product').click_button 'Add'
    sleep(1)

    # DEBUG/VERIFY
    save_screenshot 'test_3b.png'
    expect(page).to have_text 'My Cart (1)', count: 1
  end

end
