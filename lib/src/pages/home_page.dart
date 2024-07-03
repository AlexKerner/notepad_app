import 'package:flutter/material.dart';
import 'package:notepad_app/src/controller/note_controller.dart';
import 'package:notepad_app/src/models/note_model.dart';
import 'package:notepad_app/src/pages/create_note_page.dart';
import 'package:notepad_app/src/widgets/card_note_widget.dart';
import 'package:notepad_app/src/widgets/drawer_widget.dart';

final RouteObserver<ModalRoute<Object?>> routeObserver =
    RouteObserver<ModalRoute<Object?>>();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware {
  final controller = NoteController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      routeObserver.subscribe(this, ModalRoute.of(context)!);
    });
    controller.loadNotes();
    setState(() {});
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
    setState(() {});
  }

  @override
  void didPopNext() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 216, 104, 44)),
      ),
      backgroundColor: Colors.black54,
      floatingActionButton: _addTaskButton(),
      drawer: const DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Todas as notas',
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
                valueListenable: controller.listNotes,
                builder: (_, list, __) {
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
                      itemCount: list.length,
                      itemBuilder: (cntx, indx) {
                        final note = list[indx];
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

  Widget _addTaskButton() {
    return FloatingActionButton(
      backgroundColor: const Color.fromARGB(255, 216, 104, 44),
      onPressed: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const CreateNotePage(),
          ),
        );
        setState(() {
          controller.loadNotes();
        });
      },
      child: const Icon(
        Icons.edit_note_outlined,
        color: Colors.white,
        size: 35,
      ),
    );
  }
}
