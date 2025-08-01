import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Listprovider extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> saveNotes(String heading, String notes) async {
    await firestore.collection('Notes').add({'heading': heading, 'notes': notes});
    notifyListeners();
  }

  Stream<QuerySnapshot> get notes {
    return firestore
        .collection('Notes')
        .snapshots(); // adding an Stream with collection name
  }

  Future<void> deleteData(String docId) async {
    await firestore.collection('Notes').doc(docId).delete();
    notifyListeners();
  }

  Future<void> updateData(String docId, String heading, String notes) async {
    await firestore.collection('Notes').doc(docId).update({
      'heading': heading,
      'notes': notes,
    });
    notifyListeners();
  }

  Future<void> addNotes(String heading, String notes) async {
    await firestore.collection('Notes').add({
      'heading': heading,
      'notes': notes,
    });
    notifyListeners();
  }
}
