import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/googleapis_auth.dart';

import 'package:parasuke_app/provider.dart';


import '../../provider/base_controller.dart';
import '../../repository/profile/domain/profile_model.dart';
import '../../repository/relation/relation_model.dart';
import '../../repository/relation/relation_repository.dart';
import '../home/controllers/home_controller.dart';

final invitionProvider = ChangeNotifierProvider<InvitationController>((ref) {
  return InvitationController(ref)..init();
});

class InvitationController extends BaseController {
  InvitationController(this.ref);
  final ChangeNotifierProviderRef ref;

  List<Relation> _relationList = [];
  List<Relation> get relationList => _relationList;
  Profile get profile => getProfile();



  late AuthClient? authClient;

  Profile getProfile() => ref.watch(homeScreenProvider).profile!;

  Future<void> init() async {
    setBusy(true);
    _relationList.clear();
    authClient = ref.read(authServiceProvider).authClient;

    assert(authClient != null, 'Authenticated client missing!');
    final RelationsRepository repository =
        ref.read(relationsRepositoryProvider);
    final List<Relation> realtion =
        await repository.fetchRelations(uid: getProfile().id);
    final List<Relation> newRealtion =
        realtion.where((e) => e.isAccepted == false).toList();
    _relationList.addAll(newRealtion);
    setBusy(false);
  }

  Future<void> insertIntoCalendarList(
      {required String calenderId,
      required String name,
      required RelationID id}) async {
    setBusy(true);
    final CalendarApi gCalAPI = CalendarApi(authClient!);
    try {
      final CalendarListEntry request = CalendarListEntry(id: calenderId);
      await gCalAPI.calendarList.insert(request);
      await updateRelation(id: id, isAccepted: true);
      await ref.read(homeScreenProvider.notifier).init();
      log('$name $calenderId Successfull', name: 'CalendarListInsert');
    } catch (e) {
      log('$name $calenderId $e', name: 'CalendarListInsert');
    }

  setBusy(false);
  }

  Future<void> deleteIntoCalendarList(
      {required String calenderId,
      required String name,
      required RelationID id}) async {
    setBusy(true);
    final CalendarApi gCalAPI = CalendarApi(authClient!);
    try {
      await gCalAPI.calendarList.delete(calenderId);
      await updateRelation(id: id, isAccepted: false);
      await ref.read(homeScreenProvider.notifier).init();
      log('$name $calenderId Delete Successfull', name: 'CalendarListInsert');
    } catch (e) {
      log('$name $calenderId $e', name: 'CalendarListInsert');
    }

    setBusy(false);
  }

  Future<void> updateRelation(
      {required RelationID id, required bool isAccepted}) async {
        setBusy(true);
    final RelationsRepository repository =
        ref.read(relationsRepositoryProvider);
    await repository.updateRelation(
        uid: getProfile().id,
        relationID: id,
        realtion: {'isAccepted': isAccepted});
        setBusy(false);
  }
}
