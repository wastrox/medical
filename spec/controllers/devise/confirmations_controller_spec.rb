require 'rails_helper'

RSpec.describe Devise::ConfirmationsController, :type => :controller do
  before :each do
    @request.env["devise.mapping"] = Devise.mappings[:account]
    @account = Account.create(email: "nicholauskas@gmail.com", password: "12345")
  end

  describe "GET resend confirmation instructions" do

    it "renders the :new view page" do 
      get :new
      expect(response).to render_template :new
    end

    it "email body have the confirm link" do
      email = open_email(@account.email)
      email.should have_body_text(/Confirm my account/)
    end  
  end

  describe "POST #create" do
    context "with valid attributes, re-renders the :new template" do
      it "blank email" do 
        post :create
        expect(response).to render_template :new
      end

  	  it "generate confirmation token by email" do
      	post :create, account: { email: "nicholauskas@gmail.com" }
        expect(response).to render_template "devise/mailer/confirmation_instructions"
      end

      it "email was already confirmed" do
      	@account.confirm!
      	post :create, account: { email: "nicholauskas@gmail.com" }
        expect(response).to render_template :new
      end
    end
  end
end
