import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../model/app_user.dart';
import '../../../provider.dart';
import '../domain/profile_model.dart';

part 'profiles_repository.g.dart';

class ProfilesRepository {
  const ProfilesRepository(this._firestore);
  final FirebaseFirestore _firestore;

  static String profilePath(String uid, String profileId) =>
      'users/$uid/profiles/$profileId';
  static String profilesPath(String uid) => 'users/$uid/profiles';

  // create
  Future<void> addProfile({
    required UserID uid,
    required String name,
    required String pictureUrl,
    required String accessToken,
  }) async {
    final bool isExist = await isProfileExist(uid);
    if (!isExist) {
      await _firestore.collection(profilesPath(uid)).add({
        'name': name,
        'pictureUrl': pictureUrl,
        'accessToken': accessToken,
        'isNotNew': false,
        'created': DateTime.now().millisecondsSinceEpoch,
        'updated': DateTime.now().millisecondsSinceEpoch
      });
    }
  }

  // update
  Future<void> updateProfile(
          {required UserID uid,
          required String profileID,
          required Map<String, dynamic> profile}) =>
      _firestore.doc(profilePath(uid, profileID)).update(profile);

  // delete
  Future<void> deleteProfile(
      {required UserID uid, required ProfileID profileID}) async {
    // delete job
    final DocumentReference<Map<String, dynamic>> profileRef = _firestore.doc(profilePath(uid, profileID));
    await profileRef.delete();
  }

  Future<bool> isProfileExist(UserID uid) async {
    final DocumentSnapshot<Map<String, dynamic>> document = await _firestore.doc('users/$uid').get();
    final bool result = document.exists;
    return result;
  }

  // read
  Stream<Profile> watchProfile(
          {required UserID uid, required ProfileID profileID}) =>
      _firestore
          .doc(profilePath(uid, profileID))
          .withConverter<Profile>(
            fromFirestore: (DocumentSnapshot<Map<String, dynamic>> snapshot, _) =>
                Profile.fromMap(snapshot.data()!, snapshot.id),
            toFirestore: (Profile profile, _) => profile.toMap(),
          )
          .snapshots()
          .map((DocumentSnapshot<Profile> snapshot) => snapshot.data()!);

  Stream<List<Profile>> watchProfiles({required UserID uid}) =>
      queryProfiles(uid: uid)
          .snapshots()
          .map((QuerySnapshot<Profile> snapshot) => snapshot.docs.map((QueryDocumentSnapshot<Profile> doc) => doc.data()).toList());

  Query<Profile> queryProfiles({required UserID uid}) =>
      _firestore.collection(profilesPath(uid)).withConverter(
            fromFirestore: (DocumentSnapshot<Map<String, dynamic>> snapshot, _) =>
                Profile.fromMap(snapshot.data()!, snapshot.id),
            toFirestore: (Profile profile, _) => profile.toMap(),
          );

  Future<List<Profile>> fetchProfiles({required UserID uid}) async {
    final QuerySnapshot<Profile> prfiles = await queryProfiles(uid: uid).get();
    return prfiles.docs.map((QueryDocumentSnapshot<Profile> doc) => doc.data()).toList();
  }
}

@Riverpod(keepAlive: true)
ProfilesRepository profilesRepository(ProfilesRepositoryRef ref) {
  return ProfilesRepository(FirebaseFirestore.instance);
}

@riverpod
Query<Profile> profilesQuery(ProfilesQueryRef ref) {
  final User? user = ref.watch(authServiceProvider).currentUser;
  if (user == null) {
    throw AssertionError("User can't be null");
  }
  final ProfilesRepository repository = ref.watch(profilesRepositoryProvider);
  return repository.queryProfiles(uid: user.uid);
}

@riverpod
Stream<Profile> profileStream(ProfileStreamRef ref, ProfileID profileID) {
  final User? user = ref.watch(authServiceProvider).currentUser;
  if (user == null) {
    throw AssertionError("User can't be null");
  }
  final ProfilesRepository repository = ref.watch(profilesRepositoryProvider);
  return repository.watchProfile(uid: user.uid, profileID: profileID);
}
