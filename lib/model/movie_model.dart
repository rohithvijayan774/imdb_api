class Movie {
  String title;
  String thumbnail;
  String image;
  String rating;
  String trailer;

  Movie({
    required this.title,
    required this.thumbnail,
    required this.image,
    required this.rating,
    required this.trailer,
  });

  factory Movie.fromMap(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      thumbnail: json['thumbnail'],
      image: json['image'],
      rating: json['rating'],
      trailer: json['trailer'],
    );
  }
}
