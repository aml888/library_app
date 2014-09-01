class BookMailer < ActionMailer::Base
  default from: "notifications@example.com"
  
  
  def book_review_alert(user, book)
	@user = user
	@book = book
	@url = 'http://shielded-reef-5434.herokuapp.com'
	mail(to: @book.user.email, subject: 'Library Alert: New review for your book.')
  end
	
end
