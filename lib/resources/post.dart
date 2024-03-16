class Post {
  String description;
  String postUID;
  String username;
  List imageUrls;
  String profileImgUrl;
  List likes;
  DateTime publishedDateTime;
  String email;

  Post({
    required this.description,
    required this.postUID,
    required this.username,
    required this.imageUrls,
    required this.likes,
    required this.profileImgUrl,
    required this.publishedDateTime,
    required this.email,
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
      "email": email,
      "comments": [],
      "downloads": [],
    };
  }
}
