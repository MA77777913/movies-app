import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/saved_movie_model.dart';

/// Watch list and history live under the signed-in user's document:
/// users/{uid}/watchlist/{movieId} and users/{uid}/history/{movieId}.
class UserLibraryRemoteDataSource {
  static const String watchlistCollection = 'watchlist';
  static const String historyCollection = 'history';

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  UserLibraryRemoteDataSource({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _collection(String name) {
    final uid = _firebaseAuth.currentUser?.uid;
    if (uid == null) throw Exception('No user is currently logged in');
    return _firestore.collection('users').doc(uid).collection(name);
  }

  Future<List<SavedMovieModel>> getSavedMovies(String collection) async {
    final snapshot =
        await _collection(collection).orderBy('savedAt', descending: true).get();
    return snapshot.docs.map((doc) => SavedMovieModel.fromMap(doc.data())).toList();
  }

  Future<bool> exists(String collection, int movieId) async {
    final doc = await _collection(collection).doc(movieId.toString()).get();
    return doc.exists;
  }

  Future<void> save(String collection, SavedMovieModel movie) async {
    await _collection(collection).doc(movie.id.toString()).set({
      ...movie.toMap(),
      'savedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> remove(String collection, int movieId) async {
    await _collection(collection).doc(movieId.toString()).delete();
  }
}
