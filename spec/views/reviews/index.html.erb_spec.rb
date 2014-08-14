require 'rails_helper'

RSpec.describe "reviews/index", :type => :view do
  before(:each) do
    assign(:reviews, [
      Review.create!(
        :user_name => "User Name",
        :body => "MyText",
        :user_id => 1,
        :book_id => 2
      ),
      Review.create!(
        :user_name => "User Name",
        :body => "MyText",
        :user_id => 1,
        :book_id => 2
      )
    ])
  end

  it "renders a list of reviews" do
    render
    assert_select "tr>td", :text => "User Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
