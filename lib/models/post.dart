class Post {
  String title;
  String subtitle;
  String? postId;
  String? userId;
  int? color;
  List<dynamic>? comments;
  Post({
    this.color,
    this.comments,
    this.postId,
    required this.subtitle,
    required this.title,
    this.userId,
  });
}
