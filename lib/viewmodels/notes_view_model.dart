import 'package:flutter/material.dart';
import '../models/note_model.dart';
import '../repositories/notes_repository.dart';

class NotesViewModel extends ChangeNotifier {
  final NotesRepository repo;
  List<Note> notes = [];
  bool isLoading = false;

  NotesViewModel(this.repo) {
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    isLoading = true;
    notifyListeners();
    notes = await repo.getNotes();
    isLoading = false;
    notifyListeners();
  }

  Future<void> addOrUpdate({int? id, required String title, required String content}) async {
    if (id == null) {
      await repo.addNote(title, content);
    } else {
      await repo.updateNote(id, title, content);
    }
    await fetchNotes();
  }

  Future<void> deleteNote(int id) async {
    await repo.deleteNote(id);
    await fetchNotes();
  }
}