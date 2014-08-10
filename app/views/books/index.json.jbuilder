json.array!(@books) do |book|
  json.extract! book, :id, :title, :author, :picture, :ISBN, :description
  json.url book_url(book, format: :json)
end
