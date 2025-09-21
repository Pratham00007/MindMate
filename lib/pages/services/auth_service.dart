import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gcgrid/models/user_model.dart';


class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  static User? get currentUser => _auth.currentUser;

  // Generate anonymous username
  static String _generateAnonymousUsername() {
    final adjectives = [
      'Happy', 'Calm', 'Bright', 'Peaceful', 'Gentle', 'Kind', 'Wise', 'Strong',
      'Brave', 'Creative', 'Positive', 'Mindful', 'Serene', 'Joyful', 'Hopeful'
    ];
    
    final nouns = [
      'Soul', 'Spirit', 'Heart', 'Mind', 'Journey', 'Path', 'Light', 'Star',
      'Ocean', 'Mountain', 'River', 'Tree', 'Butterfly', 'Phoenix', 'Lotus'
    ];
    
    final random = Random();
    final adjective = adjectives[random.nextInt(adjectives.length)];
    final noun = nouns[random.nextInt(nouns.length)];
    final number = random.nextInt(999) + 1;
    
    return '$adjective$noun$number';
  }

  // Sign up with email and password
  static Future<UserModel?> signUpWithEmail({
    required String email,
    required String password,
    required String realName,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;
      if (user != null) {
        // Create user document in Firestore
        final anonymousUsername = _generateAnonymousUsername();
        final now = DateTime.now();
        
        final userModel = UserModel(
          uid: user.uid,
          email: email,
          realName: realName,
          anonymousUsername: anonymousUsername,
          createdAt: now,
          updatedAt: now,
        );

        await _firestore
            .collection('users')
            .doc(user.uid)
            .set(userModel.toMap());

        return userModel;
      }
    } catch (e) {
      print('Sign up error: $e');
      rethrow;
    }
    return null;
  }

  // Sign in with email and password
  static Future<UserModel?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;
      if (user != null) {
        return await getUserData(user.uid);
      }
    } catch (e) {
      print('Sign in error: $e');
      rethrow;
    }
    return null;
  }

  // Get user data from Firestore
  static Future<UserModel?> getUserData(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print('Get user data error: $e');
    }
    return null;
  }

  // Update user data
  static Future<bool> updateUserData(UserModel userModel) async {
    try {
      await _firestore
          .collection('users')
          .doc(userModel.uid)
          .update(userModel.copyWith(updatedAt: DateTime.now()).toMap());
      return true;
    } catch (e) {
      print('Update user data error: $e');
      return false;
    }
  }

  // Sign out
  static Future<void> signOut() async {
    await _auth.signOut();
  }

  // Check if anonymous username is unique
  static Future<bool> _isUsernameUnique(String username) async {
    try {
      QuerySnapshot query = await _firestore
          .collection('users')
          .where('anonymousUsername', isEqualTo: username)
          .get();
      return query.docs.isEmpty;
    } catch (e) {
      return false;
    }
  }

  // Generate unique anonymous username
  static Future<String> generateUniqueUsername() async {
    String username;
    bool isUnique = false;
    int attempts = 0;
    
    do {
      username = _generateAnonymousUsername();
      isUnique = await _isUsernameUnique(username);
      attempts++;
    } while (!isUnique && attempts < 10);
    
    if (!isUnique) {
      // Add timestamp to ensure uniqueness
      username = '${_generateAnonymousUsername()}${DateTime.now().millisecondsSinceEpoch % 10000}';
    }
    
    return username;
  }
}