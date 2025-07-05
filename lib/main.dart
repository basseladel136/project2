import 'package:flutter/material.dart';
import 'package:notes/repositories/notes_repository.dart';
import 'package:notes/repositories/supabase_notes_repository.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'viewmodels/notes_view_model.dart';
import 'views/NotesPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://ruigloomoftjbfzvykkn.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJ1aWdsb29tb2Z0amJmenZ5a2tuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTE3MjE4NTAsImV4cCI6MjA2NzI5Nzg1MH0.FZ-sjLTaEnpxKqrF_a2ELzOy-SGASedaHRr6YJQpY8w',
  );
  final NotesRepository notesRepo= SupabaseNotesRepository();
  runApp(
    ChangeNotifierProvider(
      create: (_) => NotesViewModel(notesRepo)..fetchNotes(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const NotesPage(),
    );
  }
}