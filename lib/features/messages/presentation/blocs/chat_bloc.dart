import 'package:bloc/bloc.dart';
import '../../data/models/chat_message.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<LoadChatEvent>(_onLoadChat);
  }

  Future<void> _onLoadChat(LoadChatEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));

      final List<ChatMessage> messages = [];

      emit(ChatLoaded(event.username, messages));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }
}
