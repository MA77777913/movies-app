import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies_app/features/auth/data/models/user_model.dart';

class AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRemoteDataSource({FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  Future<UserModel> login({required String email, required String password}) async {
    final credential =
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return _getUserDocument(credential.user!.uid);
  }

  Future<UserModel> register({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String avatar,
  }) async {
    final credential =
    await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    final userModel = UserModel(
      uid: credential.user!.uid,
      email: email,
      name: name,
      phone: phone,
      avatar: avatar,
    );
    await _firestore.collection('users').doc(userModel.uid).set(userModel.toMap());
    return userModel;
  }

  Future<UserModel> getCurrentUserProfile() async {
    final uid = _firebaseAuth.currentUser?.uid;
    if (uid == null) throw Exception('No user is currently logged in');
    return _getUserDocument(uid);
  }

  Future<void> resetPassword({required String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> updateProfile({
    required String name,
    required String phone,
    required String avatar,
  }) async {
    final uid = _firebaseAuth.currentUser?.uid;
    if (uid == null) throw Exception('No user is currently logged in');
    await _firestore.collection('users').doc(uid).update({
      'name': name,
      'phone': phone,
      'avatar': avatar,
    });
  }

  Future<UserModel> _getUserDocument(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (!doc.exists) throw Exception('User document not found');
    return UserModel.fromMap(doc.data()!);
  }
}