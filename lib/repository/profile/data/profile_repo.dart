import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../model/app_user.dart';
import '../domain/profile_model.dart';

part 'profile_repo.g.dart';

class ProfilesRepo {
  const ProfilesRepo(this._firestore);
  final FirebaseFirestore _firestore;

  static String profilePath(String uid, String profileId) => 'profiles/$uid';

  // create
  Future<void> addProfile(
      {required UserID uid,
      required String name,
      required String pictureUrl,
      required String accessToken,
      required String email}) async {
    final bool isExist = await isProfileExist(uid);
    if (!isExist) {
      await _firestore.collection('profiles').doc(uid).set({
        'name': name,
        'pictureUrl': pictureUrl,
        'uid': uid,
        'email': email,
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
      _firestore.collection('profiles').doc(uid).update(profile);

  // delete
  Future<void> deleteProfile({
    required UserID uid,
  }) async {
    // delete job
    final DocumentReference<Map<String, dynamic>> profileRef =
        _firestore.collection('profiles').doc(uid);
    await profileRef.delete();
  }

  Future<bool> isProfileExist(UserID uid) async {
    final DocumentSnapshot<Map<String, dynamic>> document =
        await _firestore.doc('profiles/$uid').get();
    final bool result = document.exists;
    return result;
  }

  // Query<Profile> queryProfiles({required UserID uid}) =>
  //     _firestore.collection().withConverter(
  //           fromFirestore:
  //               (DocumentSnapshot<Map<String, dynamic>> snapshot, _) =>
  //                   Profile.fromMap(snapshot.data()!, snapshot.id),
  //           toFirestore: (Profile profile, _) => profile.toMap(),
  //         );

  Query<Profile> queryProfiles() =>
      _firestore.collection('profiles').withConverter(
            fromFirestore:
                (DocumentSnapshot<Map<String, dynamic>> snapshot, _) =>
                    Profile.fromMap(snapshot.data()!, snapshot.id),
            toFirestore: (Profile profile, _) => profile.toMap(),
          );

  Future<Profile?> fetchProfile({required UserID uid}) async {
    final DocumentSnapshot<Profile> prfiles = await _firestore
        .collection('profiles')
        .doc(uid)
        .withConverter(
          fromFirestore: (DocumentSnapshot<Map<String, dynamic>> snapshot, _) =>
              Profile.fromMap(snapshot.data()!, snapshot.id),
          toFirestore: (Profile profile, _) => profile.toMap(),
        )
        .get();
    return prfiles.data();
  }

  Future<List<Profile>> fetchAllProfile() async {
    final QuerySnapshot<Profile> prfiles = await queryProfiles().get();
    return prfiles.docs
        .map((QueryDocumentSnapshot<Profile> doc) => doc.data())
        .toList();
  }

  Future<Profile?> searchByEmail(String email) async {
    try {
      final QuerySnapshot<Profile> prfiles =
          await queryProfiles().where('email', isEqualTo: email).get();
      return prfiles.docs
          .map((QueryDocumentSnapshot<Profile> doc) => doc.data())
          .toList()
          .first;
    } catch (e) {
      return null;
    }
  }
}

@Riverpod(keepAlive: true)
ProfilesRepo profilesRepo(ProfilesRepoRef ref) {
  return ProfilesRepo(FirebaseFirestore.instance);
}
