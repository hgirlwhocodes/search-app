class Book {
  final String title;
  final String description;
  final int pageCount;
  final List<String> categories;
  final List<String> author;
  final Images images;
  final int googleBooksAverageRating;
  final int googleBooksRatingsCount;

  Book({this.title, this.description, this.pageCount, this.categories, this.author, this.images, this.googleBooksAverageRating, this.googleBooksRatingsCount});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
        title: json['title'] as String,
        description: json['description'] as String,
        pageCount: json['pageCount'] as int,
        categories: List<String>.from(json['categories']),
        author: List<String>.from(json['author']),
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
