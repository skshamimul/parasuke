import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import '../../provider.dart';
import '../../repository/calendar/calendar_repository.dart';
import '../../repository/profile/data/profile_repo.dart';
import '../../repository/profile/domain/profile_model.dart';
import '../../repository/relation/relation_repository.dart';
import '../../router/app_route.dart';
import '../../router/app_route.gr.dart';
import '../../service/setup_services.dart';
import '../../state/common_state.dart';
import '../home/controllers/home_controller.dart';

final familySetupProvider =
    StateNotifierProvider<FamilySetupNotifier, CommonState>((ref) {
  return FamilySetupNotifier(ref)..init();
});

class FamilySetupNotifier extends StateNotifier<CommonState> {
  final StateNotifierProviderRef ref;
  FamilySetupNotifier(this.ref) : super(const CommonState.initializing());
  late CalendarApi gCalApi;
  final AppRouter router = getIt<AppRouter>();

  late AuthClient? authClient;
  late Profile _profile;
  Profile get profile => _profile;

  Future<void> init() async {
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
  }

  Future<void> navToPop() async {
    getIt<AppRouter>()
        .popUntil((route) => route.settings.name == 'MemberSettingRoute');
  }

  Future<void> repalceToSetMyFamily() async {
    getIt<AppRouter>()
        .popUntil((route) => route.settings.name == 'SetMyFamilyRoute');
    // await _router.popAndPush(SetMyFamilyRoute());
  }

  Future<void> subscribeToCaldender(Map<String, dynamic> formData,
      String summary, Map<String, String> userMap) async {
    state = const CommonState.loading();
    Map<String, String> _userMAP = userMap;
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
      if (mounted) {
        await ref
            .read(homeScreenProvider.notifier)
            .init()
            .then((value) => state = CommonState.success(summary));
      }
    }
  }

  Future<void> navToFamilyComplete(String value) async {
    router.replace(SetFamilyCompleteRoute(
      name: value,
    ));
  }
}
