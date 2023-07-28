import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../model/app_user.dart';
import '../../../provider.dart';
import 'relation_model.dart';

part 'relation_repository.g.dart';

class RelationsRepository {
  const RelationsRepository(this._firestore);
  final FirebaseFirestore _firestore;

  static String relationPath(String uid, String relationId) =>
      'realtions/$uid/familys/$relationId';
  static String relationsPath(String uid) => 'realtions/$uid/familys';

  // create
  Future<void> addRelation({
    required UserID uid,
    required String name,
    required String email,
    required String calenderId,
    required String hostId,
    required String userId,
    required bool isAccepted,
    required int display,
    required int birthday,
    required int role,
    required int occupation

  }) async {
    await _firestore.collection(relationsPath(uid)).add({
      'name': name,
      'email': email,
      'hostId': hostId,
      'uid': userId,
      'calenderId': calenderId,
      'isAccepted':isAccepted,
      'display': display,
      'occupation': occupation,
      'role': role,
      'birthday': birthday,
      'created': DateTime.now().millisecondsSinceEpoch,
      'updated': DateTime.now().millisecondsSinceEpoch
    });
  }

  // update
  Future<void> updateRelation(
          {required UserID uid,
          required String relationID,
          required Map<String, dynamic> realtion}) =>
      _firestore.doc(relationPath(uid, relationID)).update(realtion);

  // delete
  Future<void> deleteRelation(
      {required UserID uid, required RelationID relationID}) async {
    // delete job
    final DocumentReference<Map<String, dynamic>> relationRef =
        _firestore.doc(relationPath(uid, relationID));
    await relationRef.delete();
  }

  Future<bool> isRelationExist(UserID uid) async {
    final DocumentSnapshot<Map<String, dynamic>> document =
        await _firestore.doc('realtions/$uid').get();
    final bool result = document.exists;
    return result;
  }

  // read
  Stream<Relation> watchRelation(
          {required UserID uid, required RelationID relationID}) =>
      _firestore
          .doc(relationPath(uid, relationID))
          .withConverter<Relation>(
            fromFirestore:
                (DocumentSnapshot<Map<String, dynamic>> snapshot, _) =>
                    Relation.fromMap(snapshot.data()!, snapshot.id),
            toFirestore: (Relation relation, _) => relation.toMap(),
          )
          .snapshots()
          .map((DocumentSnapshot<Relation> snapshot) => snapshot.data()!);

  Stream<List<Relation>> watchRelations({required UserID uid}) =>
      queryRelations(uid: uid).snapshots().map(
          (QuerySnapshot<Relation> snapshot) => snapshot.docs
              .map((QueryDocumentSnapshot<Relation> doc) => doc.data())
              .toList());

  Query<Relation> queryRelations({required UserID uid}) =>
      _firestore.collection(relationsPath(uid)).withConverter(
            fromFirestore:
                (DocumentSnapshot<Map<String, dynamic>> snapshot, _) =>
                    Relation.fromMap(snapshot.data()!, snapshot.id),
            toFirestore: (Relation relation, _) => relation.toMap(),
          );

  Future<List<Relation>> fetchRelations({required UserID uid}) async {
    final QuerySnapshot<Relation> relations =
        await queryRelations(uid: uid).  get();
    return relations.docs
        .map((QueryDocumentSnapshot<Relation> doc) => doc.data())
        .toList();
  }

  Future<String?> searchByCalenderId(
      {required UserID uid, required String calendarId}) async {
    try {
      final QuerySnapshot<Relation> relations = await queryRelations(uid: uid)
          .where('calenderId', isEqualTo: calendarId)
          .get();
      return relations.docs
          .map((QueryDocumentSnapshot<Relation> doc) => doc.id)
          .toList()
          .first;
    } catch (e) {
      return null;
    }
  }
}

@Riverpod(keepAlive: true)
RelationsRepository relationsRepository(RelationsRepositoryRef ref) {
  return RelationsRepository(FirebaseFirestore.instance);
}

@riverpod
Query<Relation> relationsQuery(RelationsQueryRef ref) {
  final User? user = ref.watch(authServiceProvider).currentUser;
  if (user == null) {
    throw AssertionError("User can't be null");
  }
  final RelationsRepository repository = ref.watch(relationsRepositoryProvider);
  return repository.queryRelations(uid: user.uid);
}

@riverpod
Stream<List<Relation>> relationsStream(RelationsStreamRef ref) {
  final User? user = ref.watch(authServiceProvider).currentUser;
  if (user == null) {
    throw AssertionError("User can't be null");
  }
  final RelationsRepository repository = ref.watch(relationsRepositoryProvider);
  return repository.watchRelations(uid: user.uid);
}

@riverpod
Stream<Relation> relationStream(RelationStreamRef ref, RelationID relationID) {
  final User? user = ref.watch(authServiceProvider).currentUser;
  if (user == null) {
    throw AssertionError("User can't be null");
  }
  final RelationsRepository repository = ref.watch(relationsRepositoryProvider);
  return repository.watchRelation(uid: user.uid, relationID: relationID);
}
