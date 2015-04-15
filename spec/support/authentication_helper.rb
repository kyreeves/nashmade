module AuthenticationHelper
  def sign_in_as(user)
    visit root_path
    click_on 'Sign In'

    fill_in 'Name', with: user.name
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_on 'Log in'
  end

  def sign_out_as(user)
    visit root_path
    click_on 'Sign Out'
  end
end