import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/googleapis_auth.dart';

import '../../provider.dart';
import '../../provider/base_controller.dart';
import '../../repository/calendar/calendar_repository.dart';
import '../../repository/profile/data/profile_repo.dart';
import '../../repository/profile/domain/profile_model.dart';
import '../../repository/relation/relation_model.dart';
import '../../repository/relation/relation_repository.dart';

import '../../router/app_route.gr.dart';

import '../home/controllers/home_controller.dart';

final memberSettingProvider =
    ChangeNotifierProvider<MemberSettingController>((ref) {
  return MemberSettingController(ref)..init();
});

class MemberSettingController extends BaseController {
  MemberSettingController(this.ref);
  final ChangeNotifierProviderRef ref;

  late AuthClient? authClient;

  bool _isBirthdaySelected = false;
  bool get isBirthdaySelected => _isBirthdaySelected;

  DateTime? _birthDay;
  DateTime? get birthDay => _birthDay;

  List<CalendarListEntry> get calendarList => getCananderData();

  late Profile _profile;
  Profile get profile => _profile;
  Map<String, String> _userMAP = {};
  Map<String, String> get userMAP => _userMAP;

  List<Relation> _relationList = [];
  List<Relation> get relationList => _relationList;

  void setBirthDay(DateTime value) {
    _birthDay = value;
    notifyListeners();
  }

  Future<void> init() async {
    setBusy(true);
    _relationList.clear();
    authClient = ref.read(authServiceProvider).authClient;
    final Profile? profile = ref.watch(homeScreenProvider).profile;
    if (profile != null) {
      _profile = profile;
    } else {
      final User? currentUser = ref.read(authServiceProvider).currentUser;
      if (currentUser == null) {
        throw AssertionError("User can't be null");
      }
      final ProfilesRepo repository = ref.read(profilesRepoProvider);
      final Profile? result =
          await repository.fetchProfile(uid: currentUser.uid);
      if (result != null) {
        _profile = result;
      }
    }

    assert(authClient != null, 'Authenticated client missing!');

    final RelationsRepository repository =
        ref.read(relationsRepositoryProvider);
    final List<Relation> realtion =
        await repository.fetchRelations(uid: _profile.id);
    final List<Relation> newRealtion =
        realtion.where((e) => e.isAccepted == true).toList();
    _relationList.addAll(newRealtion);
    setBusy(false);
  }

  List<CalendarListEntry> getCananderData() =>
      ref.watch(homeScreenProvider).calendarList;

  void setStartDate(bool value) {
    _isBirthdaySelected = value;
    notifyListeners();
  }

  Future<void> navToMemberSettingDetails(Relation relation) async {
    await router.push(MemberSettingDetailsRoute(relation: relation));
  }

  Future<void> navToEditDetails(Relation relation) async {
    await router.push(EditPersonalSettingRoute(relation: relation));
  }

  Future<void> navToAddMember(String calenderName) async {
    final RelationsRepository repository =
        ref.read(relationsRepositoryProvider);
    final List<Relation> realtion =
        await repository.fetchRelations(uid: _profile.id);
    final List<String> emailList = <String>[];

    for (Relation e in realtion) {
      if (e.email.isNotEmpty) {
        emailList.add(e.email);
        _userMAP[e.email] = e.uid;
      }
    }
    _userMAP = {_profile.email: _profile.uid, ..._userMAP};
    emailList.add(_profile.email);
    notifyListeners();
    await router.push(
        AddFamilyMemberRoute(calendarName: calenderName, emailList: emailList));
    // }
  }

  Future<void> navToSetMyFamily() async {
    await router.push(SetMyFamilyRoute());
  }

  Future<void> subscribeToCaldender(
      Map<String, dynamic> formData, String summary) async {
    setBusy(true);

    final List<String> _memberList = formData['member'] as List<String>;
    final String email = formData['email'] as String;
    _memberList.add(email);

    log(_memberList.toString(), name: 'MemberList');

    final ProfilesRepo profileRepository = ref.read(profilesRepoProvider);
    final Profile? profile = await profileRepository.searchByEmail(email);
    if (profile != null) {
      log(profile.toMap().toString(), name: 'userMAP');
    }

    _userMAP = {email: profile != null ? profile.uid : '', ..._userMAP};

    log(_userMAP.toString(), name: 'userMAP');

    final CalendarApi gCalAPI = CalendarApi(authClient!);
    final Calendar request = Calendar(summary: summary);

    final Calendar result = await gCalAPI.calendars.insert(request);
    log(result.toJson().toString(), name: 'Calendar');
    // //await getIt<AppRouter>().replace(const InviteSendRoute());
    if (result.id != null) {
      final CalendarRepository calendarRepository =
          ref.read(calendarRepositoryProvider);

      await calendarRepository.addCalendar(
          title: summary,
          email: email,
          hostId: _profile.id,
          calenderId: result.id!);

      final RelationsRepository repository =
          ref.read(relationsRepositoryProvider);

      for (String element in _memberList) {
        if (element != _profile.email) {
          await gCalAPI.acl.insert(
              AclRule(
                  role: 'writer',
                  scope: AclRuleScope(value: element, type: 'user')),
              result.id!);
        }
        if (_userMAP[element]!.isNotEmpty) {
          await repository.addRelation(
              uid: _userMAP[element]!,
              name: summary,
              email: email,
              userId: profile != null ? profile.uid : '',
              calenderId: result.id!,
              isAccepted: _userMAP[element] == _profile.id,
              display: 0,
              birthday: 0,
              role: 0,
              occupation: 0,
              hostId: _profile.id);
        }
      }

      await ref.read(homeScreenProvider.notifier).init();

      await router.popAndPush(SetFamilyCompleteRoute(
        name: summary,
      ));
    }
  }

  Future<void> navToNomailScreen(String calendarName) async {
    await router.push(AddFamilyMemberNomailRoute(calendarName: calendarName));
  }

  Future<void> navtoSuccess(String calendarName) async {
    setBusy(true);
    final CalendarApi gCalAPI = CalendarApi(authClient!);
    final Calendar request = Calendar(summary: calendarName);

    final Calendar result = await gCalAPI.calendars.insert(request);
    log(result.toJson().toString(), name: 'Calendar');

    if (result.id != null) {
      final RelationsRepository repository =
          ref.read(relationsRepositoryProvider);
      await repository.addRelation(
          uid: _profile.id,
          name: calendarName,
          email: "",
          userId: '',
          calenderId: result.id!,
          isAccepted: true,
          display: 0,
          birthday: 0,
          role: 0,
          occupation: 0,
          hostId: _profile.id);
      await ref.read(homeScreenProvider.notifier).init();

      setBusy(false);

      await router.popAndPush(SetFamilyCompleteRoute(
        name: calendarName,
      ));
    }
  }

  Future<void> unLinkCalender(String calId) async {
    setBusy(true);
    final RelationsRepository repository =
        ref.read(relationsRepositoryProvider);
    final CalendarApi gCalAPI = CalendarApi(authClient!);

    final String? relationId = await repository.searchByCalenderId(
        uid: _profile.id, calendarId: calId);

    if (relationId != null) {
      await repository.deleteRelation(uid: _profile.id, relationID: relationId);
    }
    try {
      await gCalAPI.calendarList.delete(calId);
      setBusy(false);

      await router.pop('deleted');
    } catch (e) {
      await router.pop();
    }
  }

  Future<void> popDetailsScreen() async {
    await ref.watch(homeScreenProvider).init();
    await router.pop();
  }

  Future<void> updateRelation(Map<String, dynamic> value, String id) async {
    setBusy(true);
    final RelationsRepository repository =
        ref.read(relationsRepositoryProvider);
    await repository
        .updateRelation(uid: _profile.id, relationID: id, realtion: {
      'name': value['name'],
      'display': value['display'],
      'role': value['role'],
      'occupation': value['occupation'],
      'birthday': _birthDay != null ? _birthDay!.millisecondsSinceEpoch : 0
    });
    setBusy(false);
    await router.pop();
  }
}
