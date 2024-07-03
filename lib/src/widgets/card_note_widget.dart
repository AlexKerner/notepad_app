import 'package:flutter/material.dart';
import 'package:notepad_app/src/controller/note_controller.dart';
import 'package:notepad_app/src/models/note_model.dart';
import 'package:notepad_app/src/pages/edit_note_page.dart';
import 'package:notepad_app/src/pages/home_page.dart';

class CardNoteWidget extends StatelessWidget {
  final NoteModel note;
  final NoteController controller = NoteController();
  CardNoteWidget({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onLongPress: () {
            showDialog(
              context: context,
              builder: (context) => Dialog(
                backgroundColor: Colors.black,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () async {
                        final noteUpdated = NoteModel(
                            id: note.id,
                            title: note.title,
                            content: note.content,
                            isFavorite: note.isFavorite == 0 ? 1 : 0);
                        await controller.editNote(noteUpdated);
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop(noteUpdated);
                      },
                      child: SizedBox(
                        height: 80,
                        width: 80,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              note.isFavorite == 1
                                  ? Icons.star
                                  : Icons.star_border,
                              size: 30,
                              color: const Color.fromARGB(255, 216, 104, 44),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(note.isFavorite == 1
                                ? 'Desfavoritar'
                                : 'Favoritar')
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    InkWell(
                      onTap: () {
                        controller.deleteNote(note.id!);
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ));
                      },
                      child: SizedBox(
                        height: 80,
                        width: 80,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.delete_outline,
                              size: 30,
                              color: Colors.red[900],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text('Apagar')
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          onTap: () async {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditNotePage(note: note)));
          },
          child: Container(
            height: 200,
            width: 200,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 28, 28, 28)),
            child: Text(note.content),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(note.title != '' ? note.title : 'Sem título'),
              if (note.isFavorite == 1)
                const SizedBox(
                  width: 30,
                  child: Icon(
                    Icons.star,
                    size: 15,
                    color: Color.fromARGB(255, 216, 104, 44),
                  ),
                )
            ],
          ),
        )
      ],
    );
  }
}
