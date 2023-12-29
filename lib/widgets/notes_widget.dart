import 'package:flutter/material.dart';

import 'package:flutter_notes_app/model/notes.dart';
import 'package:flutter_notes_app/services/databaseServices.dart';

class NotesView extends StatefulWidget {
  static const String routename = '/notes';
  final Notes notes;
  const NotesView({
    Key? key,
    required this.notes,
  }) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  TextEditingController title = TextEditingController();
  TextEditingController data = TextEditingController();
  DataBaseServices services = DataBaseServices();
  int id = 0;
  String titles = '';
  String content = '';
  bool iscomplete = false;
  @override
  void initState() {
    super.initState();
    title.text = widget.notes.title;
    data.text = widget.notes.data;
    // titleListener();
    // DataListener();
  }

  void DataListener() {
    data.addListener(() {
      if (data.text.isNotEmpty && widget.notes.id == null) {
        content = data.text;

        // services.insertData(
        //   Notes(
        //     title: title.text,
        //     data: data.text,
        //   ),
        // );
      } else {
        services.updateData(
          Notes(
            id: widget.notes.id,
            title: title.text,
            data: data.text,
          ),
        );
      }
    });
  }

  void titleListener() {
    title.addListener(() {
      if (title.text.isNotEmpty && widget.notes.id == null) {
        titles = title.text;

        // services.insertData(
        //   Notes(
        //     title: title.text,
        //     data: data.text,
        //   ),
        // );
      } else {
        services.updateData(
          Notes(
            id: widget.notes.id,
            title: title.text,
            data: data.text,
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    title.dispose();
    data.dispose();
    title.removeListener(() {});
    data.removeListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: WillPopScope(
        onWillPop: () async {
          if ((titles.isNotEmpty || content.isNotEmpty) &&
              widget.notes.id == null) {
            services.insertData(Notes(title: titles, data: content));
            setState(() {});
          }
          return true;
        },
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                height: 100,
                margin: EdgeInsets.all(10),
                child: TextField(
                  onChanged: (value) {
                    titleListener();
                  },
                  controller: title,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(color: Colors.white, fontSize: 22),
                    enabled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(15),
                  child: TextField(
                    onChanged: (value) => DataListener(),
                    controller: data,
                    maxLines: 1000000000000000000,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Note',
                      hintStyle: TextStyle(color: Colors.white, fontSize: 22),
                      enabled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
