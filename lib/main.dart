
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import './provider_container.dart';
import './view/main_app.dart';



Future<void> main() async {
  await dotenv.load(fileName: '.env');

  runApp(
    UncontrolledProviderScope(
      container: providerContainer,
      child: const MainApp()
    )
  );
}

