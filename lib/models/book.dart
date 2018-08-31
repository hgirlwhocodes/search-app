class Book {
  final String title;
   final List<String> author;
  final String description;
  final int pageCount;
  final List<String> categories;
  final Images images;
  final int googleBooksAverageRating;
  final int googleBooksRatingsCount;

  Book({this.title, this.author, this.description, this.pageCount, this.categories, this.images, this.googleBooksAverageRating, this.googleBooksRatingsCount});

  factory Book.fromJson(Map<String, dynamic> json) {
    // var authorsFromJson = json['author'];
    // List<String> authorsList = new List<String>.from(authorsFromJson);

    // var categoriesFromJson = json['categories'];
    // List<String> categoriesList = List<String>.from(categoriesFromJson);

    // var imagesFromJson = json['images'];
    // Map<String, dynamic> imagesList = Map<String, String>.from(imagesFromJson);

    return Book(
        title: json['title'] as String,
        author: List<String>.from(json['author']),
        description: json['description'] as String,
        pageCount: json['pageCount'] as int,
        categories: List<String>.from(json['categories']),
        images: Images.fromJson(json['images']),
        googleBooksAverageRating: json['googleBooksAverageRating'] as int,
        googleBooksRatingsCount: json['googleBooksRatingsCount'] as int
        );
  }
}

class Images {
  final String smallThumbnail;
  final String thumbnail;

  Images({this.smallThumbnail, this.thumbnail});

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
        smallThumbnail: json['smallThumbnail'], thumbnail: json['thumbnail']);
  }
}

// class BookList {
//   final List<Book> books;

//   BookList({this.books});

//   factory BookList.fromJson(List<dynamic> json) {
//     List<Book> books = List<Book>();
//     books = json.map((i) => Book.fromJson(i)).toList();

//     return BookList(books: books);
//   }
// }