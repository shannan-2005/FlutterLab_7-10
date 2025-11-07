import 'package:flutter/material.dart';
import '../services/firestore_service.dart';
import '../models/word.dart';

class EditWordScreen extends StatefulWidget {
  const EditWordScreen({super.key});

  @override
  State<EditWordScreen> createState() => _EditWordScreenState();
}

class _EditWordScreenState extends State<EditWordScreen> {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Words - Alfa'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: StreamBuilder<List<Word>>(
        stream: _firestoreService.getWords(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final words = snapshot.data ?? [];
          if (words.isEmpty) {
            return const Center(child: Text('No words to edit'));
          }
          return ListView.builder(
            itemCount: words.length,
            itemBuilder: (context, index) {
              final word = words[index];
              return ListTile(
                title: Text(word.word),
                subtitle: Text(word.meaning),
                onTap: () => _showEditDialog(word),
              );
            },
          );
        },
      ),
    );
  }

  void _showEditDialog(Word word) {
    final TextEditingController _meaningController = TextEditingController(text: word.meaning);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Meaning for "${word.word}"'),
        content: TextField(
          controller: _meaningController,
          decoration: const InputDecoration(labelText: 'New Meaning'),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              try {
                await _firestoreService.updateWord(word.id, _meaningController.text);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Word updated successfully!')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error updating word: $e')),
                );
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }
}
