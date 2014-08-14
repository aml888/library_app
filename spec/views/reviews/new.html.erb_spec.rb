require 'rails_helper'

RSpec.describe "reviews/new", :type => :view do
  before(:each) do
    assign(:review, Review.new(
      :user_name => "MyString",
      :body => "MyText",
      :user_id => 1,
      :book_id => 1
    ))
  end

  it "renders new review form" do
    render

    assert_select "form[action=?][method=?]", reviews_path, "post" do

      assert_select "input#review_user_name[name=?]", "review[user_name]"

      assert_select "textarea#review_body[name=?]", "review[body]"

      assert_select "input#review_user_id[name=?]", "review[user_id]"

      assert_select "input#review_book_id[name=?]", "review[book_id]"
    end
  end
end
