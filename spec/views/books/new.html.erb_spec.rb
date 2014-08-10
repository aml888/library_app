require 'rails_helper'

RSpec.describe "books/new", :type => :view do
  before(:each) do
    assign(:book, Book.new(
      :title => "MyString",
      :author => "MyString",
      :picture => "MyString",
      :ISBN => "MyString",
      :description => "MyText"
    ))
  end

  it "renders new book form" do
    render

    assert_select "form[action=?][method=?]", books_path, "post" do

      assert_select "input#book_title[name=?]", "book[title]"

      assert_select "input#book_author[name=?]", "book[author]"

      assert_select "input#book_picture[name=?]", "book[picture]"

      assert_select "input#book_ISBN[name=?]", "book[ISBN]"

      assert_select "textarea#book_description[name=?]", "book[description]"
    end
  end
end
