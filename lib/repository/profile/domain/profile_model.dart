
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

typedef ProfileID = String;

@immutable
class Profile extends Equatable {
  const Profile({
    required this.id,
    required this.uid,
    required this.name,
    required this.pictureUrl,
    required this.accessToken,
    required this.isNotNew,
    required this.created,
    required this.updated,
    required this.email
  
  });
  final ProfileID id;
  final String uid;
  final String name;
  final String email;
  final String pictureUrl;
  final String accessToken;
  final bool isNotNew;
  final DateTime created;
  final DateTime updated;

  @override
  List<Object> get props => [name,uid,email, pictureUrl, accessToken, created, updated];

  @override
  bool get stringify => true;

  factory Profile.fromMap(Map<String, dynamic> data, String id) {
    final String name = data['name'] as String;
    final String uid = data['uid'] as String;
     final String email = data['email'] as String;
    final String pictureUrl = data['pictureUrl'] as String;
    final String accessToken = data['accessToken'] as String;
    final int createdMilliseconds = data['created'] as int;
    final int updatedMilliseconds = data['updated'] as int;
    final bool isNotNew = data['isNotNew'] as bool;
    return Profile(
        id: id,
        uid: uid,
        name: name,
        email: email,
        pictureUrl: pictureUrl,
        accessToken: accessToken,
        isNotNew: isNotNew,
        created: DateTime.fromMillisecondsSinceEpoch(createdMilliseconds),
        updated: DateTime.fromMillisecondsSinceEpoch(updatedMilliseconds));
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email':email,
      'pictureUrl': pictureUrl,
      'accessToken': accessToken,
      'isNotNew':isNotNew,
      'created': created.millisecondsSinceEpoch,
      'updated': updated.millisecondsSinceEpoch
    };
  }
}
