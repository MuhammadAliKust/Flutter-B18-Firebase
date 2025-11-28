import 'package:firebase_auth/firebase_auth.dart';

class AuthServices{
  //signup
  Future<User?> signUpUser({required String email, required String password})
  async{
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    userCredential.user!.sendEmailVerification();
    return userCredential.user;
  }
  //login
  Future<User?> loginUser({required String email, required String password})
  async{
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }
  //reset password
  Future resetPassword(String email)
  async{
   return await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}