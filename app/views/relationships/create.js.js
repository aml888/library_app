$("#follow_form").html("<%= escape_javascript(render('books/unfollow')) %>")
$("#followers").html('<%= @book.followers.count %>')