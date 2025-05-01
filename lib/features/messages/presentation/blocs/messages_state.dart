import '../../data/models/message_item.dart';

abstract class MessagesState {}

class MessagesInitial extends MessagesState {}

class MessagesLoading extends MessagesState {}

class MessagesLoaded extends MessagesState {
  final List<MessageItem> messages;

  MessagesLoaded(this.messages);
}

class MessagesError extends MessagesState {
  final String message;

  MessagesError(this.message);
}