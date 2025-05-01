class MessageItem {
  final String userImage;
  final String username;
  final String preview;
  final String time;
  final String? reaction;

  MessageItem({
    required this.userImage,
    required this.username,
    required this.preview,
    required this.time,
    this.reaction,
  });
}