import 'package:flutter/material.dart';
import 'package:talk_me/views/failure_view.dart' show failure;
import 'package:talk_me/views/inicial_view.dart' show inicio;
import 'package:talk_me/views/loading_view.dart' show loading;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return failure();
   
  }
}

