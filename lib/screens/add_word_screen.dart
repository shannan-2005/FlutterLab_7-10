import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class AddWordScreen extends StatefulWidget {
  const AddWordScreen({super.key});

  @override
  State<AddWordScreen> createState() => _AddWordScreenState();
}

class _AddWordScreenState extends State<AddWordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _wordController = TextEditingController();
  final _meaningController = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();

  Future<void> _addWord() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _firestoreService.addWord(_wordController.text, _meaningController.text);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Word added successfully!')),
        );
        _wordController.clear();
        _meaningController.clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding word: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Word - Alfa'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _wordController,
                decoration: const InputDecoration(
                  labelText: 'Word',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a word';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _meaningController,
                decoration: const InputDecoration(
                  labelText: 'Meaning',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the meaning';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _addWord,
                child: const Text('Add Word'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
