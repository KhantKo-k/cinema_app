import 'package:cinema_app/core/auth/model/user_auth_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRemoteDataSource {
  Future<UserAuthModel> login(String email, String password);
  Future<UserAuthModel> googleSignIn();
  Future<void> signOut();
  Future<UserAuthModel> signUp(String userName,String email, String password, String phone);
  Future<UserAuthModel?> restoreSession();
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSourceImpl({required this.auth, required this.firestore});

  // @override
  // Future<UserAuthModel> login(String email, String password) async {
  //   final credential = await auth.signInWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //   );
    
  //   final uid = credential.user!.uid;
  //   final doc = await firestore.collection('users').doc(uid).get();

  //   if (!doc.exists || doc.data() == null) {
  //     throw Exception('User document does not exist');
  //   }

  //   return UserAuthModel.fromFirestore(doc.id, doc.data()!);
  // }
  @override
Future<UserAuthModel> login(String email, String password) async {
  final credential = await auth.signInWithEmailAndPassword(
    email: email,
    password: password,
  );

  final user = credential.user;
  if (user == null) {
    throw Exception('Login failed');
  }

  final userRef = firestore.collection('users').doc(user.uid);
  final doc = await userRef.get();

  if (!doc.exists) {
    await userRef.set({
      'email': user.email,
      'display_name': user.displayName ?? '',
      'role': 'user',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  return UserAuthModel(
    uid: user.uid,
    email: user.email ?? '',
    displayName: user.displayName,// 👈 ADD THIS
  );
}

  @override
  Future<UserAuthModel> googleSignIn() async {
    await GoogleSignIn.instance.initialize();

    final GoogleSignInAccount googleUser = await GoogleSignIn.instance
        .authenticate();
    
    final GoogleSignInAuthentication googleAuth = googleUser.authentication;
    if (googleAuth.idToken == null) {
      throw Exception('Missing Google ID token');
    }

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    final userCred = await auth.signInWithCredential(credential);
    final user = userCred.user;
    if (user == null) {
      throw Exception('Google sign-in failed');
    }
    final userRef = firestore.collection('users').doc(user.uid);
    final doc = await userRef.get();
    if (!doc.exists) {
      await userRef.set({
        'email': user.email,
        'display_name': user.displayName,
        'role': 'user',
        'provider': 'google',
        'phone': user.phoneNumber,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
    final savedDoc = await userRef.get();
    return UserAuthModel.fromFirestore(savedDoc.id, savedDoc.data()!);
  }

  @override
  Future<void> signOut() async {
    await auth.signOut();
    await GoogleSignIn.instance.signOut();
  }

  @override
  Future<UserAuthModel> signUp(String userName,
  String email, String password, String phone) async {
    final credential = await auth.createUserWithEmailAndPassword(
      email: email.trim(), 
      password: password.trim(),
    );

    final user = credential.user;
    if(user == null) {
      throw Exception('Failed to create user');
    }

    final userRef = firestore.collection('users').doc(user.uid);
    await userRef.set({
      'email': email.trim(),
      'display_name': userName,
      'role': 'user',
      'phone': phone,
      'createdAt': FieldValue.serverTimestamp(),
    });

    final doc = await userRef.get();

    if(!doc.exists || doc.data() == null) {
      throw Exception('Failed to create user document in Firestore');
    }

    return UserAuthModel.fromFirestore(doc.id, doc.data()!);
  }

  @override
  Future<UserAuthModel?> restoreSession() async {
    final firebaseUser = auth.currentUser;
    if(firebaseUser == null) return null;

    final doc = await firestore.collection('users').doc(firebaseUser.uid).get();
    if(!doc.exists || doc.data() == null) return null;

    return UserAuthModel.fromFirestore(doc.id, doc.data()!);
  }
}
