import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/note_model.dart';
import 'notes_repository.dart';

class SupabaseNotesRepository implements NotesRepository {
  final client = Supabase.instance.client;

  @override
  Future<List<Note>> getNotes() async {
    final data = await client.from('notes').select().order('created_at', ascending: false);
    return (data as List)
        .map((e) => Note.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> addNote(String title, String content) async => await client.from('notes').insert({'title': title, 'content': content});

  @override
  Future<void> updateNote(int id, String title, String content) async => await client
        .from('notes')
        .update({'title': title, 'content': content})
        .eq('id', id);

  @override
  Future<void> deleteNote(int id) async {
    await client.from('notes').delete().eq('id', id);
  }
}