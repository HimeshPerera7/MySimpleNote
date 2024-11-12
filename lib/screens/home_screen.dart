import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mysimplenote/db_helper/sql_helper.dart';
import 'package:mysimplenote/models/note_model.dart';
import 'package:mysimplenote/screens/create_note.dart';
import 'package:mysimplenote/screens/widgets/note_card.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> notes = [];

  final StreamController<SwipeRefreshState> _controller =  StreamController<SwipeRefreshState>.broadcast();

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
   _controller.sink.add(SwipeRefreshState.loading);
    final loadedNotes = await DatabaseHelper.instance.getNotes();
    setState(() {
      notes = loadedNotes;
    });
    _controller.sink.add(SwipeRefreshState.hidden);
    notes = await DatabaseHelper.instance.getNotes();

    if (notes.isEmpty) {
      await DatabaseHelper.instance.insertNote(Note(
        title: 'Welcome to MySimpleNote!',
        description: 'Thank you for using MySimpleNote! This app is designed to help you easily capture your thoughts, ideas, and important information. Start by creating your first note and make the most out of your day!',
      ));
      notes = await DatabaseHelper.instance.getNotes();
    }
  }


  Future<void> _refresh() async {
    await _loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MySimpleNote"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.cyanAccent,
        shadowColor: Colors.cyanAccent,
        elevation: 5,
        centerTitle: true,
        actions: [
            PopupMenuButton(
              icon: Icon(Icons.info_outline, color: Colors.cyanAccent),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: DeveloperInfoCard(),
                ),
              ],
            ),
          ],
      ),

      body: notes.isEmpty
          ? const Center(
              child: Text("No notes available", 
                style: TextStyle(color: Colors.cyanAccent),                
              )
            )
          :SwipeRefresh.material(
              stateStream: _controller.stream,
              onRefresh: _refresh,
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: <Widget>[
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    return NoteCard(
                      note: notes[index],
                      index: index,
                      onNoteDeleted: onNoteDeleted,
                    );
                  },
                ),
              ],
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        child: const Icon(
          Icons.add, 
          color: Colors.black, 
          size: 35,),
        backgroundColor: Colors.cyanAccent,
      ),
    );
  }

  void onNewNoteCreated(Note note) async {
    await DatabaseHelper.instance.insertNote(note);
    _loadNotes();
  }

  void onNoteDeleted(int index) async {
    final noteToDelete = notes[index];
    await DatabaseHelper.instance.deleteNote(noteToDelete.id!);
    _loadNotes();
  }

  Future<void> _addNote() async {
       final newNote = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CreateNote(
                onNewNoteCreated: onNewNoteCreated,
              ),
            ),
          );
          if (newNote != null) onNewNoteCreated(newNote);
  } 
}


class DeveloperInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.cyanAccent,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'DEVELOPER PROFILE',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.cyanAccent[700],
              ),
            ),

            SizedBox(height: 8),

            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/images/avatar.png'),
            ),

            SizedBox(height: 8),

            Text(
              'HIMESH PERERA',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.cyanAccent,
              ),
            ),

            SizedBox(height: 2),

            SelectableText(
              'himeshofficial7@gmail.com',
              style: TextStyle(
                color: Colors.cyan[800],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
