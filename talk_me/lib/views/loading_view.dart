import 'package:flutter/material.dart';

class loading extends StatelessWidget {
  const loading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CircularProgressIndicator(),
          Text('cargando...')
        ],
      ),
    );
  }
}

