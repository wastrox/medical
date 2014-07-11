require 'rails_helper'

describe Scope do
	before :each do
		@scope = Scope.new(title: "Работник медицины" )
		@scope.save
	end

	context "error save" do
		it "is invalid without a title" do
			expect(@scope).to be_valid
		end
	end

	context "NOT NULL constraint failed" do
		it "is invalid without a description" do
			expect(@scope.description.nil?).to eq false
		end
	end

    context "morpher" do
    	it "returns has_one scope" do
			morpher = @scope.morpher
			expect(morpher.scope.title).to eq @scope.title
		end

		it "return Именительный [:И] падеж" do
			expect( @scope.singular "И" ).to eq @scope.title
		end
    end
end

