import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/word.dart';
import '../models/user.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection references
  CollectionReference get _wordsCollection => _firestore.collection('dictionary_words');
  CollectionReference get _usersCollection => _firestore.collection('users');

  // Add a new word
  Future<void> addWord(String word, String meaning) async {
    await _wordsCollection.add({
      'word': word,
      'meaning': meaning,
      'timestamp': FieldValue.serverTimestamp(),
      'brand': 'Alfa',
    });
  }

  // Get all words as stream
  Stream<List<Word>> getWords() {
    return _wordsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Word.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
    });
  }

  // Search words by query
  Stream<List<Word>> searchWords(String query) {
    if (query.isEmpty) {
      return getWords();
    }
    return _wordsCollection
        .where('word', isGreaterThanOrEqualTo: query)
        .where('word', isLessThan: query + 'z')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) => Word.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
        });
  }

  // Update word meaning
  Future<void> updateWord(String id, String newMeaning) async {
    await _wordsCollection.doc(id).update({'meaning': newMeaning});
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
