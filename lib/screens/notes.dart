import 'package:flutter/material.dart';
import 'package:flutter_notes_app/model/notes.dart';
import 'package:flutter_notes_app/services/databaseServices.dart';
import 'package:flutter_notes_app/widgets/notes_widget.dart';
import 'package:provider/provider.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final GlobalKey<ScaffoldState> scaffoldstate = GlobalKey<ScaffoldState>();
  DataBaseServices services = DataBaseServices();
  List<Notes> notes = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldstate,
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              'NOTES',
              style: TextStyle(
                fontSize: 45,
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Consumer<DataBaseServices>(
        builder: (context, provider, child) {
          return StreamBuilder<List<Notes>>(
            stream: provider.notesStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                notes = snapshot.data ?? [];

                return Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemCount: notes.length,
                            itemBuilder: (context, index) {
                              var note = notes[index];

                              List<Color> colors = [
                                Colors.yellowAccent.withOpacity(0.98),
                                Colors.purpleAccent.withOpacity(0.99),
                                Colors.red.withOpacity(0.98),
                                Colors.lightBlue.withOpacity(0.99),
                                Colors.lightGreen.withOpacity(0.99),
                              ];

                              Color containercolor =
                                  colors[index % colors.length];
                              return InkWell(
                                onTap: () {
                                  Future.delayed(
                                    Duration(milliseconds: 50),
                                    () {
                                      Navigator.pushNamed(
                                        context,
                                        NotesView.routename,
                                        arguments: note,
                                      );
                                    },
                                  );
                                },
                                child: Dismissible(
                                  key: Key(note.id.toString()),
                                  child: Container(
                                    margin: EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        width: 2,
                                        color: Colors.white38,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                            top: 20,
                                            left: 20,
                                          ),
                                          child: Text(
                                            note.title,
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                            top: 15,
                                            left: 20,
                                            right: 10,
                                          ),
                                          child: Text(
                                            note.data,
                                            maxLines: 3,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 23,
                                              fontWeight: FontWeight.normal,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  onDismissed: (direction) {
                                    setState(() {
                                      services.DeleteData(note.id!);
                                      notes.remove(note);
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 530, left: 335),
                            child: FloatingActionButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  NotesView.routename,
                                  arguments: Notes(title: '', data: ''),
                                );
                              },
                              child: Icon(
                                Icons.add,
                                size: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Text('error'),
                );
              }
            },
          );
        },
      ),
    );
  }
}
