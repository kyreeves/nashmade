require 'rails_helper'

feature 'user edits product' do

  context 'as an authorized user' do
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      sign_in_as user
    end

    scenario 'user edits product successfully' do
      product = FactoryGirl.create(:product, user: user)

      visit edit_product_path(product)
      fill_in 'product_name', with: 'Awesome Wood Chair'

      click_on 'Update Product'

      expect(page).to have_content('Awesome Wood Chair')
      expect(page).to have_content('this is a description for the wood chair')
      expect(page).to have_content('$15.00')
    end

    scenario 'user updates invalid product' do
      visit new_product_path

      fill_in 'product_name', with: ''
      fill_in 'product_description', with: 'this is a description for the wood chair'
      fill_in 'product_price', with: '15'

      click_on 'Create Product'

      click_link 'Edit'

      fill_in 'product_name', with: ''

      click_on 'Update Product'

      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content('this is a description for the wood chair')
      expect(page).to have_content('15')
    end
  end
end
