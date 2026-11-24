import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:campus_lost/app.dart';

void main() {
  // TODO: Call WidgetsFlutterBinding.ensureInitialized() before Firebase initialization.
  // TODO: Initialize Firebase with Firebase.initializeApp() before runApp().

  runApp(const ProviderScope(child: CampusLostApp()));
}
