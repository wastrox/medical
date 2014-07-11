require 'rails_helper'

describe Category do
	before :each do
		@category = Category.new(name: "Космонавтика" )
		@category.save
	end

	context "error save" do
		it "is invalid without a name" do
			expect(@category).to be_valid
		end
	end

	context "NOT NULL constraint failed" do
		it "is invalid without a description" do
			expect(@category.description.nil?).to eq false
		end
	end

    context "morpher" do
    	it "returns has_one associations to category" do
			morpher = @category.morpher
			expect(morpher.category.name).to eq @category.name
		end

		it "return Именительный [:И] падеж" do
			expect( @category.singular "И" ).to eq @category.name
		end
    end
end
