import 'package:cloud_firestore/cloud_firestore.dart';

class Goal {
  final String id;
  final String goal;
  final String description;
  final DateTime timestamp;
  final String category;

  Goal({
    required this.id,
    required this.goal,
    required this.description,
    required this.timestamp,
    required this.category,
  });

  factory Goal.fromMap(Map<String, dynamic> map, String id) {
    return Goal(
      id: id,
      goal: map['goal'] ?? '',
      description: map['description'] ?? '',
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      category: map['category'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'goal': goal,
      'description': description,
      'timestamp': timestamp,
      'category': category,
    };
  }
}
