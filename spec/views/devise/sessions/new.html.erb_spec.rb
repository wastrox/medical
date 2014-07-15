require "rails_helper"

describe "sessions/new" do
  it "infers the controller path" do
    expect(controller.request.path_parameters[:controller]).to eq("sessions")
    expect(controller.controller_path).to eq("sessions")
  end

  it "infers the controller action" do
    expect(controller.request.path_parameters[:action]).to eq("new")
  end
end

describe "sessions/_form" do
  it "includes a link to new" do
    expect(controller.request.path_parameters[:action]).to be_nil
  end
end

RSpec.describe "check interface create sessions", :type => :feature do
  before :each do
    Account.create!(:email => 'user@example.com', :password => '12345')
  end

  it 'signin process success' do
    visit '/login'

    within("form#new_account") do
      fill_in 'Email', :with => 'user@example.com'
      fill_in 'Password', :with => '12345'
    end
    
    click_button 'Sign in'
    expect(page).to have_content 'Выход'
  end

  it 'visit receive confirmation instructions link' do
    visit '/login'
    click_link("Didn't receive confirmation instructions?")
    
    expect(page).to have_content 'Email'
  end

  it 'visit receive Sign up link' do
    visit '/login'
    click_link("Sign up")
    
    expect(page).to have_content 'Email'
  end
end

