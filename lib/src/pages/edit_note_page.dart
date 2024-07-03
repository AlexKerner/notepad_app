import 'package:flutter/material.dart';
import 'package:notepad_app/src/controller/note_controller.dart';
import 'package:notepad_app/src/models/note_model.dart';
import 'package:notepad_app/src/pages/home_page.dart';

class EditNotePage extends StatefulWidget {
  final NoteModel note;
  const EditNotePage({super.key, required this.note});

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  late TextEditingController titleContent;
  late TextEditingController contentContent;
  final NoteController controller = NoteController();

  @override
  void initState() {
    super.initState();
    titleContent = TextEditingController(text: widget.note.title);
    contentContent = TextEditingController(text: widget.note.content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      floatingActionButton: _saveNoteButton(),
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text(widget.note.title),
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
                      fillColor: const Color.fromARGB(255, 28, 28, 28),
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
                      fillColor: const Color.fromARGB(255, 28, 28, 28),
                      hintText: "Escreva sua nota aqui...",
                      hintStyle: Theme.of(context).textTheme.bodyLarge,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none),
                      contentPadding:
                          const EdgeInsets.only(left: 20, right: 20, top: 50)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _saveNoteButton() {
    return FloatingActionButton(
      backgroundColor: const Color.fromARGB(255, 216, 104, 44),
      onPressed: () async {
        final updatedNote = NoteModel(
          id: widget.note.id,
          title: titleContent.text,
          content: contentContent.text,
          isFavorite: widget.note.isFavorite,
        );
        await controller.editNote(updatedNote);
        // ignore: use_build_context_synchronously
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const HomePage()));
      },
      child: const Icon(
        Icons.save,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}
