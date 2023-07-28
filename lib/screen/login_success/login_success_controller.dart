import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googleapis/calendar/v3.dart' as cal;
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
import '../settings/controllers/settings.dart';

final loginSuccessScreenProvider =
    ChangeNotifierProvider<LoginSuccessScreenController>((ref) {
  return LoginSuccessScreenController(ref)..init();
});

class LoginSuccessScreenController extends BaseController {
  LoginSuccessScreenController(this.ref);
  final ChangeNotifierProviderRef<LoginSuccessScreenController> ref;

  LoginSuccessState _loginSuccessState = LoginSuccessState.initial;
  LoginSuccessState get loginSuccessState => _loginSuccessState;
  Map<String, String> userMAP = {};
  bool get isProfileSetup => getIsProfileSetup();
  late AuthClient? authClient;

  User? currentUser;

  Profile? _profile;
  Profile? get profile => _profile;

  Future<void> init() async {
    final bool isMemberSetup = ref.watch(Settings.setMemberScreenProvider);
    if (isMemberSetup) {
      authClient = ref.read(authServiceProvider).authClient;

      assert(authClient != null, 'Authenticated client missing!');

      currentUser = ref.read(authServiceProvider).currentUser;
      if (currentUser == null) {
        throw AssertionError("User can't be null");
      }
    }
  }

  bool getIsProfileSetup() => ref.watch(Settings.setAddProfileProvider);

  void setWidget(LoginSuccessState state) {
    _loginSuccessState = state;
    notifyListeners();
  }

  Future<void> navToAddMember(String title) async {
    userMAP.clear();
    final RelationsRepository repository =
        ref.read(relationsRepositoryProvider);
    final List<Relation> realtion =
        await repository.fetchRelations(uid: currentUser!.uid);
    final List<String> emailList = <String>[];

    for (Relation e in realtion) {
      if (e.email.isNotEmpty) {
        emailList.add(e.email);
        userMAP[e.email] = e.uid;
      }
    }
    userMAP = {'${currentUser!.email}': currentUser!.uid, ...userMAP};
    emailList.add(currentUser!.email!);

    log(userMAP.toString(), name: 'userMAP');

    await router.push(
        LoginAddFamilyMemberRoute(emailList: emailList, calendarName: title));
  }

  void navToFamilyMemberFinish(Map<String, dynamic>? formData) {
    setWidget(LoginSuccessState.addMemberFinish);
    router.pop();
  }

  Future<void> addCalenderForGmailUser(
      Map<String, dynamic> formData, String summary) async {
    setBusy(true);

    final List<String> memberList = formData['member'] as List<String>;

    final String email = formData['email'] as String;
    memberList.add(email);
    final cal.CalendarApi gCalAPI = cal.CalendarApi(authClient!);
    final cal.Calendar request = cal.Calendar(summary: summary);
    final cal.Calendar result = await gCalAPI.calendars.insert(request);
    if (result.id != null) {
      final CalendarRepository calendarRepository =
          ref.read(calendarRepositoryProvider);

      await calendarRepository.addCalendar(
          title: summary,
          email: email,
          hostId: currentUser!.uid,
          calenderId: result.id!);

      final ProfilesRepo profileRepository = ref.read(profilesRepoProvider);
      final Profile? profile = await profileRepository.searchByEmail(email);

      final RelationsRepository repository =
          ref.read(relationsRepositoryProvider);

      userMAP = {email: profile != null ? profile.uid : '', ...userMAP};

      for (String element in memberList) {
        if (element != currentUser!.email) {
          await gCalAPI.acl.insert(
              cal.AclRule(
                  role: 'writer',
                  scope: cal.AclRuleScope(value: element, type: 'user')),
              result.id!);
        }

        if (userMAP[element]!.isNotEmpty) {
          await repository.addRelation(
              uid: userMAP[element]!,
              name: summary,
              email: email,
              userId: profile != null ? profile.uid : '',
              calenderId: result.id!,
              isAccepted: userMAP[element]! == currentUser!.uid,
              display: 0,
              birthday: 0,
              role: 0,
              occupation: 0,
              hostId: currentUser!.uid);
        }
      }

      await ref.read(homeScreenProvider.notifier).init();

      setWidget(LoginSuccessState.addMemberFinish);
      await router.pop();
    }
  }

  void nevToHome() {
    setWidget(LoginSuccessState.initial);
    ref.read(Settings.setMemberScreenProvider.notifier).set(false);
  }

  Future<void> navtoSuccess(String calendarName) async {
    userMAP.clear();
    setBusy(true);
    final RelationsRepository repository =
        ref.read(relationsRepositoryProvider);
    final List<Relation> realtion =
        await repository.fetchRelations(uid: currentUser!.uid);
    final List<String> emailList = <String>[];

    for (Relation e in realtion) {
      if (e.email.isNotEmpty) {
        emailList.add(e.email);
        userMAP[e.email] = e.uid;
      }
    }

    final cal.CalendarApi gCalAPI = cal.CalendarApi(authClient!);
    final cal.Calendar request = cal.Calendar(summary: calendarName);
    final cal.Calendar result = await gCalAPI.calendars.insert(request);

    if (result.id != null) {
      final CalendarRepository calendarRepository =
          ref.read(calendarRepositoryProvider);

      await calendarRepository.addCalendar(
          title: calendarName,
          email: '',
          hostId: currentUser!.uid,
          calenderId: result.id!);

      final RelationsRepository repository =
          ref.read(relationsRepositoryProvider);

      userMAP.forEach((key, value) async {
        await gCalAPI.acl.insert(
            cal.AclRule(
                role: 'writer',
                scope: cal.AclRuleScope(value: key, type: 'user')),
            result.id!);

        if (value.isNotEmpty) {
          await repository.addRelation(
              uid: value,
              name: calendarName,
              email: key,
              userId: value,
              calenderId: result.id!,
              isAccepted: value == currentUser!.uid,
              display: 0,
              birthday: 0,
              role: 0,
              occupation: 0,
              hostId: currentUser!.uid);
        }
      });
      setWidget(LoginSuccessState.addMemberFinish);

      setBusy(false);
      await router.pop();
    }
  }
}

enum LoginSuccessState { initial, addMember, addMemberFinish, finish }
