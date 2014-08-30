require 'rails_helper'

RSpec.describe Book, :type => :model do

	let(:untitled_book) { Book.new(picture: 'book1.jpg', ISBN: '978-3-16-148410-0') }
	let(:titled_book) {Book.new(title: "Dealers of Lightning")}
	

	context "testing picture validation" do
	
		before :each do
			@book = build :book
		end
		
		
		it "should notify the user of a missing picture" do
			@book.picture = nil
			@book.should_not be_valid
			@book.errors.full_messages.should include "must not be blank"
			
		end
	end
	
	
	context "testing title validation" do
		it "will be invalid when it doesn't have a title" do
			untitled_book = build :book
			untitled_book.title = nil
			expect(untitled_book.valid?).to be_false
		end
		
			
		it "will be valid when it has a title" do
			untitled_book = build :book
			expect(untitled_book.valid?).to be_true
			
		end
	end
	
	
	context "testing ISBN validation" do
		it "will be invalid when it doesn't have an ISBN" do
			titled_book = build :book
			titled_book.ISBN = nil
			expect(titled_book.valid?).to be_false
		end
		
		it "will be invalid when ISBN is too short" do
			titled_book.ISBN = "1234"
			expect(titled_book.valid?).to be_false
		end
	end
end
