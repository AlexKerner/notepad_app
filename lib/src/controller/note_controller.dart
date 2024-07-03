import 'package:flutter/material.dart';
import 'package:notepad_app/src/models/note_model.dart';
import 'package:notepad_app/src/services/database_service.dart';

class NoteController {
  late final listNotes = ValueNotifier<List<NoteModel>>([]);
  NoteController() {
    loadNotes();
  }
  Future<void> loadNotes() async {
    listNotes.value = await DatabaseService.instance.getAllNotes();
  }

  Future<void> addNote(NoteModel note) async {
    await DatabaseService.instance.addNote(note);
    await loadNotes();
  }

  Future<void> editNote(NoteModel note) async {
    await DatabaseService.instance.editNote(note);
    print(note);
    await loadNotes();
  }

  Future<void> deleteNote(int id) async {
    await DatabaseService.instance.deleteNote(id);
    loadNotes();
  }

  List<NoteModel> getFavoritedNotes() {
    return listNotes.value.where((note) => note.isFavorite == 1).toList();
  }
}
