import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_b18_backend/models/user.dart';


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
  Future<UserModel> getUserByID(String userID) async {
    return await FirebaseFirestore.instance
        .collection('userCollection')
        .doc(userID)
        .get()
        .then((val) {
        return UserModel.fromJson(val.data()!);
    });
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
