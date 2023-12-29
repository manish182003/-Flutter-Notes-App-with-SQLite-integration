import 'package:flutter/material.dart';

import 'package:flutter_notes_app/routes.dart';
import 'package:flutter_notes_app/screens/notes.dart';
import 'package:flutter_notes_app/services/databaseServices.dart';

import 'package:provider/provider.dart';

void main() {
  runApp( ChangeNotifierProvider(
    create: (context) => DataBaseServices(),
    child: MainApp(),),);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
     onGenerateRoute: (settings) => routes(settings),
      home: NotesScreen(),
    );
  }
}
