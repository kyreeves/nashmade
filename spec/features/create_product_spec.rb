require 'rails_helper'

feature 'user creates product' do

  context 'as an authorized user' do
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      sign_in_as user
    end

    scenario 'user creates valid product' do
      visit new_product_path

      fill_in 'product_name', with: 'Wood Chair'
      fill_in 'product_description', with: 'this is a description for the wood chair'
      fill_in 'product_price', with: '15'

      click_on 'Create Product'

      expect(page).to have_content('Wood Chair')
      expect(page).to have_content('this is a description for the wood chair')
      expect(page).to have_content('$15.00')
    end

    scenario 'user creates invalid product' do
      visit new_product_path

      fill_in 'product_name', with: ''
      fill_in 'product_description', with: 'this is a description for the wood chair'
      fill_in 'product_price', with: '15'

      click_on 'Create Product'

      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content('this is a description for the wood chair')
      expect(page).to have_content('15')
    end
  end
end
