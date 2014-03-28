# encoding: utf-8
require 'spec_helper'


require "account"

describe Account do
	it "is falid create new account" do
		account = Account.new(email: "test_spec@text.com", password: "12345")
		expect(account).to be_valid
	end

	it "is invalid without a email" do
		expect(Account.new(email: nil, password: "12345")).to have(2).errors_on(:email)
	end

	it "is invalid without a password" do
		expect(Account.new(email: "test_spec@text.com", password: nil)).to have(1).errors_on(:password)
	end

	it "is invalid with a duplicate email adress" do
		Account.create(email: "test_spec@text.com", password: "12345")
		account = Account.new(email: "test_spec@text.com", password: "12345")
		
		expect(account).to have(1).errors_on(:email)
	end


end

