require 'rails_helper'

describe Devise::SessionsController do  
  before :each do
    @request.env["devise.mapping"] = Devise.mappings[:account]
  end

  describe "GET login user" do
    it "renders the :new view" do 
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "re-renders the :new template" do 
        post :create
        expect(response).to render_template :new
      end
    end
  end
end
