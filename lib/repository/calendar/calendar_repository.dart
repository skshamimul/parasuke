import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'calendar_model.dart';

part 'calendar_repository.g.dart';

class CalendarRepository {
  const CalendarRepository(this._firestore);
  final FirebaseFirestore _firestore;

  static String calendarPath = 'calendars';

  // create
  Future<void> addCalendar({
    required String title,
    required String email,
    required String hostId,
    required String calenderId,
  }) async {
    await _firestore.collection(calendarPath).add({
      'title': title,
      'email': email,
      'hostId': hostId,
      'calenderId': calenderId,
      'created': DateTime.now().millisecondsSinceEpoch,
      'updated': DateTime.now().millisecondsSinceEpoch
    });
  }

  // update
  Future<void> updateProfile(
          {required String id, required Map<String, dynamic> profile}) =>
      _firestore.collection(calendarPath).doc(id).update(profile);

  // delete
  Future<void> deleteProfile({
    required String id,
  }) async {
    // delete job
    final DocumentReference<Map<String, dynamic>> profileRef =
        _firestore.collection(calendarPath).doc(id);
    await profileRef.delete();
  }

  // Query<Profile> queryProfiles({required UserID uid}) =>
  //     _firestore.collection().withConverter(
  //           fromFirestore:
  //               (DocumentSnapshot<Map<String, dynamic>> snapshot, _) =>
  //                   Profile.fromMap(snapshot.data()!, snapshot.id),
  //           toFirestore: (Profile profile, _) => profile.toMap(),
  //         );

  Query<Calendar> queryCalendar() =>
      _firestore.collection(calendarPath).withConverter(
            fromFirestore:
                (DocumentSnapshot<Map<String, dynamic>> snapshot, _) =>
                    Calendar.fromMap(snapshot.data()!, snapshot.id),
            toFirestore: (Calendar profile, _) => profile.toMap(),
          );

  Future<Calendar?> fetchCalendar({required String id}) async {
    final DocumentSnapshot<Calendar> calendar = await _firestore
        .collection(calendarPath)
        .doc(id)
        .withConverter(
          fromFirestore: (DocumentSnapshot<Map<String, dynamic>> snapshot, _) =>
              Calendar.fromMap(snapshot.data()!, snapshot.id),
          toFirestore: (Calendar calendar, _) => calendar.toMap(),
        )
        .get();
    return calendar.data();
  }

  Future<List<Calendar>> fetchAllCalendar() async {
    final QuerySnapshot<Calendar> calendar = await queryCalendar().get();
    return calendar.docs
        .map((QueryDocumentSnapshot<Calendar> doc) => doc.data())
        .toList();
  }

    Future<Calendar?> searchByEmail(String email) async {
    try {
      final QuerySnapshot<Calendar> calendar =
          await queryCalendar().where('email', isEqualTo: email).get();
      return calendar.docs
          .map((QueryDocumentSnapshot<Calendar> doc) => doc.data())
          .toList()
          .first;
    } catch (e) {
      return null;
    }
  }
}

@Riverpod(keepAlive: true)
CalendarRepository calendarRepository(CalendarRepositoryRef ref) {
  return CalendarRepository(FirebaseFirestore.instance);
}
