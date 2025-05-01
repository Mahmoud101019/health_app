import '../../data/models/chat_message.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final String username;
  final List<ChatMessage> messages;

  ChatLoaded(this.username, this.messages);
}

class ChatError extends ChatState {
  final String message;

  ChatError(this.message);
}