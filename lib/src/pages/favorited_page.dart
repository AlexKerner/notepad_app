import 'package:flutter/material.dart';
import 'package:notepad_app/src/controller/note_controller.dart';
import 'package:notepad_app/src/models/note_model.dart';
import 'package:notepad_app/src/widgets/card_note_widget.dart';
import 'package:notepad_app/src/widgets/drawer_widget.dart';

class FavoritedPage extends StatelessWidget {
  final _controller = NoteController();
  FavoritedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: Colors.black54,
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 216, 104, 44)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Notas Favoritas',
                  style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 350,
                child: TextField(
                    onChanged: (value) {},
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40)),
                        prefixIcon: const Icon(Icons.search),
                        hintText: 'Pesquisar nota...')),
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(),
              const SizedBox(
                height: 20,
              ),
              ValueListenableBuilder<List<NoteModel>>(
                valueListenable: _controller.listNotes,
                builder: (_, list, __) {
                  final favorited = _controller.getFavoritedNotes();
                  return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 8,
                        childAspectRatio: 0.70,
                      ),
                      itemCount: favorited.length,
                      itemBuilder: (cntx, indx) {
                        final note = favorited[indx];
                        return CardNoteWidget(note: note);
                      });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
