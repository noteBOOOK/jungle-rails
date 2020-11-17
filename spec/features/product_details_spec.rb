require 'rails_helper'

RSpec.feature "Visitor navigates to Product detail page", type: :feature, js: true do
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

  scenario "They can navigate to a product details page" do
    # ACT
    visit root_path
    save_screenshot "test_2a.png"

    first('article header').click
    sleep(1)

    # DEBUG/VERIFY
    save_screenshot "test_2b.png"
    expect(page).to have_css 'section.products-show'
    
  end



end
