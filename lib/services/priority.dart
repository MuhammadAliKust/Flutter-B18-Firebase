import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_b18_backend/models/priority.dart';

class PriorityServices {
  ///Create Priority
  Future createPriority(PriorityModel model) async {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection('priorityCollection')
        .doc();

    return await FirebaseFirestore.instance
        .collection('priorityCollection')
        .doc(docRef.id)
        .set(model.toJson(docRef.id));
  }

  ///Get All Priority
  Stream<List<PriorityModel>> getAllPriority() {
    return FirebaseFirestore.instance
        .collection('priorityCollection')
        .snapshots()
        .map(
          (priorityList) => priorityList.docs
              .map(
                (priorityJson) => PriorityModel.fromJson(priorityJson.data()),
              )
              .toList(),
        );
  }

  ///Get Priorites
  Future<List<PriorityModel>> getPriorites(){
    return FirebaseFirestore.instance
        .collection('priorityCollection')
        .get()
        .then((list)=>list.docs
        .map((json)=> PriorityModel.fromJson(json.data())).toList(),
    );
  }
  ///Delete Priority
  Future deletePriority(PriorityModel model) async {
    return await FirebaseFirestore.instance
        .collection('priorityCollection')
        .doc(model.docId)
        .delete();
  }

  ///Update Priority
  Future updatePriority(PriorityModel model) async {
    return await FirebaseFirestore.instance
        .collection('priorityCollection')
        .doc(model.docId)
        .update({'name': model.name});
  }
}
