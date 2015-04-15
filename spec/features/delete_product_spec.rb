require 'rails_helper'

feature 'user deletes product' do

  context 'as an authorized user' do
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      sign_in_as user
    end

    scenario 'user deletes product' do
      visit new_product_path

      fill_in 'product_name', with: 'Wood Chair'
      fill_in 'product_description', with: 'this is a description for the wood chair'
      fill_in 'product_price', with: '15'

      click_on 'Create Product'
      click_link 'Delete'
      expect(page).to have_content("Product has been deleted")
    end
  end
end
