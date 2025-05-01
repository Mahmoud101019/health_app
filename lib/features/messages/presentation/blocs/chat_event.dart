abstract class ChatEvent {}

class LoadChatEvent extends ChatEvent {
  final String username;

  LoadChatEvent(this.username);
}