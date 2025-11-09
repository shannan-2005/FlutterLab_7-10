import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/word.dart';
import '../models/user.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection references
  CollectionReference get _goalsCollection => _firestore.collection('goals');
  CollectionReference get _usersCollection => _firestore.collection('users');

  // Add a new goal
  Future<void> addGoal(String goal, String description) async {
    await _goalsCollection.add({
      'goal': goal,
      'description': description,
      'timestamp': FieldValue.serverTimestamp(),
      'category': 'Personal',
    });
  }

  // Get all goals as stream
  Stream<List<Goal>> getGoals() {
    return _goalsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Goal.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
    });
  }

  // Search goals by query
  Stream<List<Goal>> searchGoals(String query) {
    if (query.isEmpty) {
      return getGoals();
    }
    return _goalsCollection
        .where('goal', isGreaterThanOrEqualTo: query)
        .where('goal', isLessThan: query + 'z')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) => Goal.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
        });
  }

  // Update goal description
  Future<void> updateGoal(String id, String newDescription) async {
    await _goalsCollection.doc(id).update({'description': newDescription});
  }

  // Get user by email and password
  Future<User?> getUser(String email, String password) async {
    final querySnapshot = await _usersCollection
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password)
        .limit(1)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      final doc = querySnapshot.docs.first;
      return User.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }
    return null;
  }
}
