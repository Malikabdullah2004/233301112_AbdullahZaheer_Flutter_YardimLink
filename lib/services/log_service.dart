import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class LogService {

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<void> addLog(
    String action,
  ) async {

    try {

      await _firestore
          .collection('logs')
          .add({

        'userId':
            FirebaseAuth
                .instance
                .currentUser
                ?.uid,

        'action': action,

        'timestamp': Timestamp.now(),
      });

    } catch (e) {

      debugPrint(e.toString());
    }
  }
}