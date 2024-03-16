class Comment {
  String commentUID;
  String description;
  DateTime datePublished;
  String username;
  String profileImgUrl;
  String email;

  Comment({
    required this.commentUID,
    required this.description,
    required this.datePublished,
    required this.username,
    required this.profileImgUrl,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      "commentUID": commentUID,
      "description": description,
      "datePublished": datePublished,
      "username": username,
      "profileImgUrl": profileImgUrl,
      "email": email,
    };
  }
}
