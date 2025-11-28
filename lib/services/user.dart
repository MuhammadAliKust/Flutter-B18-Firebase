import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_b18_backend/models/User.dart';

import '../models/user.dart';

class UserServices {
  ///Create User
  Future createUser(UserModel model) async {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection('UserCollection')
        .doc();

    return await FirebaseFirestore.instance
        .collection('UserCollection')
        .doc(docRef.id)
        .set(model.toJson(docRef.id));
  }

  ///Get All User
  Stream<List<UserModel>> getAllUser() {
    return FirebaseFirestore.instance
        .collection('UserCollection')
        .snapshots()
        .map(
          (UserList) => UserList.docs
          .map(
            (UserJson) => UserModel.fromJson(UserJson.data()),
      )
          .toList(),
    );
  }

  ///Get Priorites
  Future<List<UserModel>> getUserByID(){
    return FirebaseFirestore.instance
        .collection('UserCollection')
        .get()
        .then((list)=>list.docs
        .map((json)=> UserModel.fromJson(json.data())).toList(),
    );
  }
  ///Delete User
  Future deleteUser(UserModel model) async {
    return await FirebaseFirestore.instance
        .collection('UserCollection')
        .doc(model.docId)
        .delete();
  }

  ///Update User
  Future updateUser(UserModel model) async {
    return await FirebaseFirestore.instance
        .collection('UserCollection')
        .doc(model.docId)
        .update({'name': model.name});
  }
}
