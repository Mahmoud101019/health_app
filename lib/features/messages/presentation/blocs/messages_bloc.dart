import 'package:bloc/bloc.dart';
import '../../data/models/message_item.dart';
import 'messages_event.dart';
import 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  MessagesBloc() : super(MessagesInitial()) {
    on<LoadMessagesEvent>(_onLoadMessages);
  }

  Future<void> _onLoadMessages(
    LoadMessagesEvent event,
    Emitter<MessagesState> emit,
  ) async {
    emit(MessagesLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));

      final List<MessageItem> messages = [
        MessageItem(
          userImage: 'assets/images/user_placeholder.png',
          username: 'Salah edd Reaction',
          preview: 'You sent a voice message',
          time: '4m',
          reaction: '❤️',
        ),
        MessageItem(
          userImage: 'assets/images/user_placeholder.png',
          username: 'Dr. Derek Shepherd',
          preview: 'message',
          time: '1h',
          reaction: '❤️',
        ),
        MessageItem(
          userImage: 'assets/images/user_placeholder.png',
          username: 'Szloboda',
          preview: 'You sent a voice message',
          time: '3h',
          reaction: '❤️',
        ),
        MessageItem(
          userImage: 'assets/images/user_placeholder.png',
          username: 'Alisson',
          preview: 'You added reaction',
          time: '7h',
        ),
        MessageItem(
          userImage: 'assets/images/user_placeholder.png',
          username: 'Virgil',
          preview: 'You added reaction',
          time: '10h',
        ),
        MessageItem(
          userImage: 'assets/images/user_placeholder.png',
          username: 'Trent',
          preview: 'You sent a voice message',
          time: '1d',
        ),
        MessageItem(
          userImage: 'assets/images/user_placeholder.png',
          username: 'Nunez',
          preview: 'You sent a photo',
          time: '2d',
        ),
        MessageItem(
          userImage: 'assets/images/user_placeholder.png',
          username: 'Gakpo',
          preview: 'You added reaction',
          time: '4d',
          reaction: '⭐',
        ),
      ];

      emit(MessagesLoaded(messages));
    } catch (e) {
      emit(MessagesError(e.toString()));
    }
  }
}
