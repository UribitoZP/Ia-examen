import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/chat_model.dart';
import 'chat_event.dart';
import 'chat_state.dart';
import '../services/openAI_services.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final OpenAIService openAIService;
  List<Message> _messages = [];

  ChatBloc(this.openAIService) : super(ChatInitial()) {
    on<SendMessageEvent>(_onSendMessage);
    on<ClearChatEvent>(_onClearChat);
    on<StartChatEvent>((event, emit) async {
   emit(ChatLoading());
   await Future.delayed(Duration(seconds: 1)); // opcional, para mostrar loading
   emit(ChatSuccess([]));
});
  }

  void _onStartChat(StartChatEvent event, Emitter<ChatState> emit) {
    emit(ChatSuccess(List.from(_messages)));
  }

  void _onClearChat(ClearChatEvent event, Emitter<ChatState> emit) {
    _messages.clear();
    emit(ChatInitial());
  }

  Future<void> _onSendMessage(
      SendMessageEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoading());

    _messages.add(Message(content: event.message, isUser: true));
    try {
      final aiResponse = await openAIService.sendMessage(event.message);
      _messages.add(Message(content: aiResponse.trim(), isUser: false));
      emit(ChatSuccess(List.from(_messages)));
    } catch (e) {
      emit(ChatFailure(e.toString()));
    }
  }
}
