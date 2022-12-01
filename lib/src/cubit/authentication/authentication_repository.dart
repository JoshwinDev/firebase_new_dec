import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_task_firebase_june_ndz/src/models/user_model.dart';

class AuthenticationRepository {
  Future<UserCredential> createUser(String email, String password) async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return user;
  }

 Future<UserCredential> loginUser(String email, String password) async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return user;
  }
 Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

 Future<void> storeUserData(UserModel userModel) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
   await users.doc(userModel.id).set(userModel.toJson());
  }
}
