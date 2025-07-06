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
    on<ClearChatEvent>((event, emit) {
      _messages.clear();
      emit(ChatInitial());
    });
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
