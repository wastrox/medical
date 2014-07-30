require "rails_helper"

describe Account do
	before :each do
		@accoutn = Account.new(email: "nicholauskas@gmail.com", password: "12345")
		@accoutn.save
	end

	it "is valid with email or password" do
		expect(@accoutn).to be_valid
	end

	it "is record exists in the table" do
		expect( Account.exists? email: 'nicholauskas@gmail.com' ).to eq true
	end
	context "exception the record" do
		it "is invalid without a email" do
			accoutn = Account.new( email: "nicholauskas@gmail", password: "12345" )
			accoutn.valid?
			expect(accoutn.errors[:email].size).to eq(1)
		end

		it "is invalid without a email can't be blank" do
			accoutn = Account.new( password: "12345" )
			accoutn.valid?
			expect(accoutn.errors[:email].size).to eq(1)
		end

		it "is invalid without a password can't be blank" do
			accoutn = Account.new( email: "nicholauskas@gmail.com" )
			accoutn.valid?
			expect(accoutn.errors[:password].size).to eq(1)
		end

		it "is invalid with a duplicate email address" do
			accoutn = Account.create( email: "nicholauskas@gmail.com", password: "12345" )
			accoutn.valid?
			expect(accoutn.errors[:email].size).to eq(1)
		end

		it "is invalid with a duplicate email address because of uppercase" do
			accoutn = Account.create( email: "NICholauskas@gmail.com", password: "12345" )
			accoutn.valid?
			expect(accoutn.errors[:email].size).to eq(1)
		end
	end

	it "is confirmed?" do 
		expect(@accoutn.confirmed?).to eq(false)
	end

	it "is confirm!" do 
		@accoutn.confirm!
		expect(@accoutn.confirmed?).to eq(true)
	end

	it "profile type is not specified" do 
		expect(@accoutn.type_not_specified?).to eq(true)
	end

	it "profile type applicant" do 
		@accoutn.create_type("Applicant")
		expect(@accoutn.applicant?).to eq(true)
	end

	it "profile type employer" do 
		@accoutn.create_type("Employer")
		expect(@accoutn.employer?).to eq(true)
	end
end