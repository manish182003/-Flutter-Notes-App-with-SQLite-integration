import 'package:flutter/material.dart';
import 'package:flutter_notes_app/model/notes.dart';

import 'package:flutter_notes_app/widgets/notes_widget.dart';

Route<dynamic> routes(RouteSettings settings) {
  switch (settings.name) {
    case NotesView.routename:
      var notes = settings.arguments as Notes;
      return MaterialPageRoute(
        builder: (context) => NotesView(notes: notes),
      );

    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('Error Occured'),
          ),
        ),
      );
  }
}
