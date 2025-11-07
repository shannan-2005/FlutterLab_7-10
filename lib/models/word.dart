import 'package:cloud_firestore/cloud_firestore.dart';

class Word {
  final String id;
  final String word;
  final String meaning;
  final DateTime timestamp;
  final String brand;

  Word({
    required this.id,
    required this.word,
    required this.meaning,
    required this.timestamp,
    required this.brand,
  });

  factory Word.fromMap(Map<String, dynamic> map, String id) {
    return Word(
      id: id,
      word: map['word'] ?? '',
      meaning: map['meaning'] ?? '',
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      brand: map['brand'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'word': word,
      'meaning': meaning,
      'timestamp': timestamp,
      'brand': brand,
    };
  }
}
