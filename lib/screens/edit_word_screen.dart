import 'package:flutter/material.dart';
import '../services/firestore_service.dart';
import '../models/word.dart';

class EditGoalScreen extends StatefulWidget {
  const EditGoalScreen({super.key});

  @override
  State<EditGoalScreen> createState() => _EditGoalScreenState();
}

class _EditGoalScreenState extends State<EditGoalScreen> {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Goals'),
        backgroundColor: const Color(0xFF87CEEB),
      ),
      body: StreamBuilder<List<Goal>>(
        stream: _firestoreService.getGoals(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final goals = snapshot.data ?? [];
          if (goals.isEmpty) {
            return const Center(child: Text('No goals to edit'));
          }
          return ListView.builder(
            itemCount: goals.length,
            itemBuilder: (context, index) {
              final goal = goals[index];
              return ListTile(
                leading: const Icon(Icons.flag, color: Colors.greenAccent),
                title: Text(goal.goal),
                subtitle: Text(goal.description),
                onTap: () => _showEditDialog(goal),
              );
            },
          );
        },
      ),
    );
  }

  void _showEditDialog(Goal goal) {
    final TextEditingController _descriptionController = TextEditingController(text: goal.description);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Description for "${goal.goal}"'),
        content: TextField(
          controller: _descriptionController,
          decoration: const InputDecoration(labelText: 'New Description'),
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
                await _firestoreService.updateGoal(goal.id, _descriptionController.text);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Goal updated successfully!')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error updating goal: $e')),
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
