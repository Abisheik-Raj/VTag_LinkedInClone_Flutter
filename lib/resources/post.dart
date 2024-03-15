class Post {
  String description;
  String postUID;
  String username;
  List imageUrls;
  String profileImgUrl;
  List likes;
  DateTime publishedDateTime;

  Post({
    required this.description,
    required this.postUID,
    required this.username,
    required this.imageUrls,
    required this.likes,
    required this.profileImgUrl,
    required this.publishedDateTime,
  });

  Map<String, dynamic> toJson() {
    return {
      "description": description,
      "postUID": postUID,
      "username": username,
      "imageUrls": imageUrls,
      "likes": likes,
      "profileImgUrl": profileImgUrl,
      "publishedDateTime": publishedDateTime,
    };
  }
}
