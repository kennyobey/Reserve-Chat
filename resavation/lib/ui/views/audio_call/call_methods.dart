import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../model/call_model.dart';

class CallMethods {
  final CollectionReference<Map<String, dynamic>> callCollection =
      FirebaseFirestore.instance.collection('calls');

  Stream<DocumentSnapshot<Map<String, dynamic>>> callStream(
          {required String uid}) =>
      callCollection.doc(uid).snapshots();

  Future<bool> makeCall({required CallModel call}) async {
    try {
      call.hasDialled = true;
      Map<String, dynamic> hasDialledMap = call.toMap(call);

      call.hasDialled = false;
      Map<String, dynamic> hasNotDialledMap = call.toMap(call);

      await callCollection.doc(call.callerId).set(hasDialledMap);
      await callCollection.doc(call.receiverId).set(hasNotDialledMap);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> endCall({required CallModel call}) async {
    try {
      await callCollection.doc(call.callerId).delete();
      await callCollection.doc(call.receiverId).delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
