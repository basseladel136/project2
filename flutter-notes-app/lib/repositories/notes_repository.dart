import '../models/note_model.dart';

abstract class NotesRepository {
  Future<List<Note>> getNotes();
  Future<void> addNote(String content,String title);
  Future<void> updateNote(int id, String content,String title);
  Future<void> deleteNote(int id);
}