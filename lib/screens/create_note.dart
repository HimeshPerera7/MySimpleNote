import 'package:flutter/material.dart';
import 'package:mysimplenote/models/note_model.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({super.key, required this.onNewNoteCreated});

  final Function(Note) onNewNoteCreated;

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  void _saveNote(){
    if (titleController.text.isEmpty || bodyController.text.isEmpty) {
      return;
    }
    final note = Note(
      description: bodyController.text,
      title: titleController.text,
    );
   Navigator.of(context).pop(note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Note'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.cyanAccent,
        shadowColor: Colors.cyanAccent,
        elevation: 5,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            
            TextFormField(
              controller: titleController,
              style: const TextStyle(fontSize: 28,),
              decoration: const InputDecoration(
                hintText: "Title",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyanAccent),
                ),

                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyanAccent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyanAccent),
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            TextFormField(
              controller: bodyController,
              style: const TextStyle(fontSize: 18),
              decoration: const InputDecoration(
                  hintText: "Your Story",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyanAccent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyanAccent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyanAccent),
                ),
              ),
              maxLines: null,
            ),

          ],
        ),
      ),

      floatingActionButton: GestureDetector(
        onTap: _saveNote,
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
                Icons.save,
                color: Colors.black,
                size: 35,
              ),

              const SizedBox(width: 5),

              const Text(
                'Save',
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
