import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

typedef RelationID = String;

@immutable
class Relation extends Equatable {
  const Relation({
    required this.id,
    required this.name,
    required this.email,
    required this.hostId,
    required this.uid,
    required this.calenderId,
    required this.isAccepted,
    required this.display,
    required this.birthday,
    required this.role,
    required this.occupation,
    required this.created,
    required this.updated,
  });
  final RelationID id;
  final String name;
  final String email;
  final String hostId;
  final String uid;
  final String calenderId;
  final bool isAccepted;
  final int display;
  final DateTime birthday;
  final int role;
  final int occupation;
  final DateTime created;
  final DateTime updated;

  @override
  List<Object> get props => [
        name,
        email,
        hostId,
        calenderId,
        isAccepted,
        display,
        birthday,
        role,
        occupation,
        created,
        updated
      ];

  @override
  bool get stringify => true;

  factory Relation.fromMap(Map<String, dynamic> data, String id) {
    final String name = data['name'] as String;
    final String email = data['email'] as String;
    final String hostId = data['hostId'] as String;
    final String uid = data['uid'] as String;
    final String calenderId = data['calenderId'] as String;
    final bool isAccepted = data['isAccepted'] as bool;
    final int display = data['display'] as int;
    final int occupation = data['occupation'] as int;
    final int role = data['role'] as int;
    final int birthdayMilliseconds = data['birthday'] as int;
    final int createdMilliseconds = data['created'] as int;
    final int updatedMilliseconds = data['updated'] as int;

    return Relation(
        id: id,
        name: name,
        email: email,
        hostId: hostId,
        uid: uid,
        calenderId: calenderId,
        isAccepted: isAccepted,
        display: display,
        occupation: occupation,
        role: role,
        birthday: DateTime.fromMillisecondsSinceEpoch(birthdayMilliseconds),
        created: DateTime.fromMillisecondsSinceEpoch(createdMilliseconds),
        updated: DateTime.fromMillisecondsSinceEpoch(updatedMilliseconds));
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'hostId': hostId,
      'uid': uid,
      'calenderId': calenderId,
      'isAccepted': isAccepted,
      'display': display,
      'occupation': occupation,
      'role': role,
      'birthday': birthday.millisecondsSinceEpoch,
      'created': created.millisecondsSinceEpoch,
      'updated': updated.millisecondsSinceEpoch
    };
  }
}
