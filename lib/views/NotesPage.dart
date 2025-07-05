import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note_model.dart';
import '../viewmodels/notes_view_model.dart';
import '../widgets/note_title.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<NotesViewModel>(); // ✅ UI هيسمع للتغييرات

    return Scaffold(
      appBar: AppBar(title: const Text('Notes')),
      body: vm.isLoading
          ? const Center(child: CircularProgressIndicator())
          : vm.notes.isEmpty
          ? const Center(child: Text('No notes yet.'))
          : ListView.builder(
        itemCount: vm.notes.length,
        itemBuilder: (context, index) {
          final note = vm.notes[index];
          return NoteTile(
            note: note,
            onEdit: () => _showEditor(context, vm, note),
            onDelete: () => vm.deleteNote(note.id),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showEditor(context, vm, null),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showEditor(BuildContext context, NotesViewModel vm, Note? note) {
    final titleController = TextEditingController(text: note?.title ?? '');
    final contentController = TextEditingController(text: note?.content ?? '');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(note == null ? 'Add Note' : 'Edit Note'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: contentController,
                maxLines: 5,
                decoration: const InputDecoration(labelText: 'Content'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              final title = titleController.text.trim();
              final content = contentController.text.trim();

              if (title.isEmpty && content.isEmpty) return;

              vm.addOrUpdate(
                id: note?.id,
                title: title,
                content: content,
              );

              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(note == null ? 'Note added' : 'Note updated')),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}