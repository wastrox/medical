require 'rails_helper'

RSpec.describe "devise/registrations/new page", :type => :feature do
	it 'success registration account' do
	  	visit '/signup'

	  	within("form#new_account") do
	        fill_in 'Email', :with => 'user@example.com'
	        fill_in 'Password', :with => 'password'
		end
	    click_button 'Sign up'
    	expect(page).to have_content 'Ваш профиль не активирован'
	end

	it 'is invalid with a duplicate email address' do
	  	account = Account.create!(email: 'nicholauskas@gmail.com', password: "12345")
	  	visit '/signup'
	  	within("form#new_account") do
	        fill_in 'Email', :with => 'nicholauskas@gmail.com'
	        fill_in 'Password', :with => '12345'
		end
	    click_button 'Sign up'
    	expect(page).to have_content 'Email уже существует'
	end

	it 'visit receive confirmation instructions link' do
	  visit '/signup'
	  click_link("Didn't receive confirmation instructions?")
	  
	  expect(page).to have_content 'Email'
	end

	it 'visit receive Sign up link' do
	  visit '/signup'
	  click_link("Sign in")
	  
	  expect(page).to have_content 'Email'
	end
end
