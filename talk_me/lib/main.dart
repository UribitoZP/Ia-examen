import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk_me/bloc/chat_bloc.dart';
import 'package:talk_me/bloc/chat_state.dart';
import 'package:talk_me/views/failure_view.dart';
import 'package:talk_me/views/inicial_view.dart';
import 'package:talk_me/views/loading_view.dart';
import 'package:talk_me/views/succes_view.dart';
import 'package:talk_me/services/openAI_services.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Talk Me!',
      home: BlocProvider(
        create: (context) => ChatBloc(OpenAIService()),
        child: const ChatScreenManager(),
      ),
    );
  }
}

class ChatScreenManager extends StatelessWidget {
  const ChatScreenManager({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
    builder: (context, state) {
      if (state is ChatInitial) {
        return Inicio();
      } else if (state is ChatLoading) {
        return Loading(); // SOLO aparece al iniciar
      } else if (state is ChatSuccess) {
        return SuccessView();
      } else if (state is ChatFailure) {
        return Failure();
      } else {
        return Center(child: Text('Estado desconocido'));
      }
    },
  );
  }
}