import 'package:firebase_database/firebase_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tally_note_flutter/state/auth/providers/user_id_provider.dart';
import 'package:tally_note_flutter/state/auth/type_def/user_id.dart';
import 'package:tally_note_flutter/state/constant/firebase_collections.dart';

final userRefProvider = Provider((ref) {
  final UserId? userId = ref.watch<UserId?>(userIdProvider);
  // final userId = FirebaseAuth.instance.currentUser?.uid;
  if (userId == null) {
    return null;
  }
  FirebaseDatabase database = FirebaseDatabase.instance;
  final userRef = database.ref().child(USERS).child(userId);
  return userRef;
});
