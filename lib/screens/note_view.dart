import 'package:flutter/material.dart';
import 'package:mysimplenote/db_helper/sql_helper.dart';
import 'package:mysimplenote/models/note_model.dart';
import 'package:mysimplenote/screens/note_edit.dart';

class NoteView extends StatelessWidget {
  const NoteView(
      {super.key,
      required this.note,
      required this.index,
      required this.onNoteDeleted});

  final Note note;
  final int index;
  final Function(int) onNoteDeleted;

  Future<void> _deleteNote() async {
    await DatabaseHelper.instance.deleteNote(note.id!);
    onNoteDeleted(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Note View"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.cyanAccent,
        shadowColor: Colors.cyanAccent,
        elevation: 5,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Delete This?"),
                    content: Text("Note '${note.title}' will be deleted!"),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                          await _deleteNote();
                          Navigator.of(context)
                              .pop();
                        },
                        child: const Text("DELETE"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("CANCEL"),
                      )
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.delete, size: 28,),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: const TextStyle(
                fontSize: 26,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              note.description,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteEdit(
                note: note,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), 
            color: Colors.cyanAccent,
          ),
          width: 100,
          height: 50,
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Icon(
                Icons.edit,
                color: Colors.black,
                size: 30,
              ),

              const SizedBox(width: 5),

              const Text(
                'Edit',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
