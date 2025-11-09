import 'package:flutter/material.dart';
import '../services/firestore_service.dart';
import '../models/word.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Goals'),
        backgroundColor: const Color(0xFF87CEEB),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search for a goal',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Goal>>(
              stream: _firestoreService.searchGoals(_searchController.text),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                final goals = snapshot.data ?? [];
                if (goals.isEmpty) {
                  return const Center(child: Text('No goals found'));
                }
                return ListView.builder(
                  itemCount: goals.length,
                  itemBuilder: (context, index) {
                    final goal = goals[index];
                    return ListTile(
                      leading: const Icon(Icons.flag, color: Colors.greenAccent),
                      title: Text(goal.goal),
                      subtitle: Text(goal.description),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
