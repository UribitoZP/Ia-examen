import 'package:equatable/equatable.dart';
import '../models/chat_model.dart';

abstract class ChatState extends Equatable {
  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatSuccess extends ChatState {
  final List<Message> messages;

  ChatSuccess(this.messages);

  @override
  List<Object> get props => [messages];
}

class ChatFailure extends ChatState {
  final String error;

  ChatFailure(this.error);

  @override
  List<Object> get props => [error];
}
