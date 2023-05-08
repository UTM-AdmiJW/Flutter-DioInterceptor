
import 'package:flutter/material.dart';

import './auth_state_card.dart';



class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.yellow),
      home: Scaffold(
        appBar: AppBar(title: const Text('Auth Demo')),
        body: ListView(
          children: const [
            AuthStateCard(),
          ],
        )
      ),
    );
  }
}