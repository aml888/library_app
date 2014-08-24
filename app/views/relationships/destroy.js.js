$("#follow_form").html("<%= escape_javascript(render('books/follow')) %>")
$("#followers").html('<%= @book.followers.count %>')