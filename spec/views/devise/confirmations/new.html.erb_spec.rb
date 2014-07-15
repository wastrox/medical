require 'rails_helper'

RSpec.describe "the confirmation process", :type => :feature do
  before :each do
    @account = Account.create!(:email => 'user@example.com', :password => '12345')
  end

  context 'visit receive confirmation instructions page' do
  
    it 'success delivered mail confirm' do
      visit '/confirmation/new'

      within("form#new_account") do
        fill_in 'Email', :with => 'user@example.com'
      end
      click_button 'Resend confirmation instructions'
      
      expect(page).to have_content 'You will receive an email with instructions about how to confirm your account in a few minutes.'
    end

    it 'email invalid' do
      visit '/confirmation/new'

      within("form#new_account") do
        fill_in 'Email', :with => 'user@example'
      end
      click_button 'Resend confirmation instructions'
      
      expect(page).to have_content 'Email not found'
    end

    it 'blank email address' do
      visit '/confirmation/new'

      within("form#new_account") do
        fill_in 'Email', :with => ''
      end
      click_button 'Resend confirmation instructions'
      
      expect(page).to have_content 'Email не может быть пустым'
    end

    it 'Email was already confirmed' do
      visit '/confirmation/new'
      @account.confirm!

      within("form#new_account") do
        fill_in 'Email', :with => 'user@example.com'
      end
      click_button 'Resend confirmation instructions'
      
      expect(page).to have_content 'Email was already confirmed, please try signing in'
    end
  end
end