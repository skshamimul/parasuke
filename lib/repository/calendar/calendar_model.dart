import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Calendar extends Equatable {
  const Calendar({
    required this.title,
    required this.email,
    required this.hostId,
    required this.calenderId,
    required this.created,
    required this.updated,
  });

  final String title;
  final String email;
  final String hostId;
  final String calenderId;
  final DateTime created;
  final DateTime updated;

  @override
  List<Object> get props => [email, title, hostId, calenderId];

  @override
  bool get stringify => true;

  factory Calendar.fromMap(Map<String, dynamic> data, String id) {
    final String title = data['title'] as String;
    final String email = data['email'] as String;
    final String hostId = data['hostId'] as String;
    final String calenderId = data['calenderId'] as String;
    final int createdMilliseconds = data['created'] as int;
    final int updatedMilliseconds = data['updated'] as int;

    return Calendar(
        title: title,
        hostId: hostId,
        email: email,
        calenderId: calenderId,
        created: DateTime.fromMillisecondsSinceEpoch(createdMilliseconds),
        updated: DateTime.fromMillisecondsSinceEpoch(updatedMilliseconds));
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'email': email,
      'hostId': hostId,
      'calenderId': calenderId,
      'created': created.millisecondsSinceEpoch,
      'updated': updated.millisecondsSinceEpoch
    };
  }
}
