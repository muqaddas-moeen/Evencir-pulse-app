import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/user_model.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser({required UserModel userData}) async {
    await _firestore.collection('users').doc(userData.id).set(userData.toMap());
  }

  Future<UserModel?> fetchUserData(String uid) async {
    DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data() as Map<String, dynamic>);
    }
    return null;
  }
}
