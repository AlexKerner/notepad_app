import 'package:flutter/material.dart';
import 'package:notepad_app/src/controller/note_controller.dart';
import 'package:notepad_app/src/models/note_model.dart';

class CreateNotePage extends StatefulWidget {
  const CreateNotePage({super.key});

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  final controller = NoteController();
  final titleContent = TextEditingController();
  final contentContent = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      floatingActionButton: _addTaskButton(),
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: const Text('Nova Nota'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 330,
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: titleContent,
                  style: Theme.of(context).textTheme.headlineSmall,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 28, 28, 28),
                      contentPadding: EdgeInsets.all(20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none),
                      hintText: "Título",
                      hintStyle: Theme.of(context).textTheme.headlineSmall),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: contentContent,
                  maxLines: 22,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 28, 28, 28),
                      hintText: "Escreva sua nota aqui...",
                      hintStyle: Theme.of(context).textTheme.bodyLarge,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none),
                      contentPadding:
                          EdgeInsets.only(left: 20, right: 20, top: 50)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _addTaskButton() {
    return FloatingActionButton(
      backgroundColor: Color.fromARGB(255, 216, 104, 44),
      onPressed: () async {
        final note = NoteModel(
            title: titleContent.text,
            content: contentContent.text,
            isFavorite: 0);
        await controller.addNote(note);
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop(
          note,
        );
      },
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}
