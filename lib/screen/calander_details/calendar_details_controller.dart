import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/googleapis_auth.dart';

import '../../provider.dart';
import '../../provider/base_controller.dart';
import '../../repository/profile/domain/profile_model.dart';
import '../../repository/relation/relation_model.dart';
import '../../repository/relation/relation_repository.dart';
import '../../router/app_route.dart';
import '../../router/app_route.gr.dart';

import '../../service/setup_services.dart';
import '../home/controllers/home_controller.dart';

final 
    calanderDetailsProvider = ChangeNotifierProvider.autoDispose<CalanderDetailsController>(
        (ChangeNotifierProviderRef<CalanderDetailsController> ref) {
  return CalanderDetailsController(ref)..init();
});

class CalanderDetailsController extends BaseController {
  CalanderDetailsController(this.ref);
  final ChangeNotifierProviderRef ref;

  DateTime _startDateTime = DateTime.now();
  DateTime get startDateTime => _startDateTime;

  DateTime _endDateTime = DateTime.now().add(const Duration(minutes: 10));
  DateTime get endDateTime => _endDateTime;

  String? _emoji;
  String? get emoji => _emoji;

  String _selectedPlace = '';
  String get selectedPlace => _selectedPlace;

  bool _isStartSelected = false;
  bool get isStartSelected => _isStartSelected;
  bool _isEndSelected = false;
  bool get isEndSelected => _isEndSelected;
  List<String> _selectedMember = [];
  List<String> get selectedMember => _selectedMember;
  String _addMemberFieldText = '';
  String get addMemberFieldText => _addMemberFieldText;
  late CalendarApi gCalApi;

  Map<String, String> _memberList = {};

  Future<void> init() async {
    setBusy(true);
    _addMemberFieldText = '';
    _selectedMember.clear();
    final Profile? profile = ref.watch(homeScreenProvider).profile;
    final AuthClient? authClient = ref.read(authServiceProvider).authClient;
    assert(authClient != null, 'Authenticated client missing!');

    gCalApi = CalendarApi(authClient!);

    if (profile != null) {
      final RelationsRepository repository =
          ref.read(relationsRepositoryProvider);
      final List<Relation> realtionList =
          await repository.fetchRelations(uid: profile.uid);

      _memberList[profile.email] = profile.name;
      _selectedMember.add(profile.email);
      // _addMemberFieldText = profile.name;
      for (var element in realtionList) {
        _memberList[element.calenderId] = element.name;
        _selectedMember.add(element.calenderId);
        // _addMemberFieldText = '${element.name}, $_addMemberFieldText';
      }
      log(_selectedMember.toString(), name: 'FromNavToAddMember');
      setBusy(false);
    }
  }

  Future<String?> navToAddIcon() async {
    final String? result = await router.push(const AddIconWidgetRoute());
    return result;
  }

  Future<void> navToAddMember() async {
    await router.push(AddMemberWidgetRoute(memberList: _memberList));
  }



  void setEmogi(String value) {
    _emoji = value;
    debugPrint(value);
    notifyListeners();
  }

  Future<void> navToAddLocation() async {
    await router.push(AddLocationRoute());
  }

  Future<void> setLocation(String value) async {
    _selectedPlace = value;
    notifyListeners();

    await getIt<AppRouter>().pop();
  }

  void setStartDateTime(DateTime newDateTime) {
    _startDateTime = newDateTime;
    _endDateTime = newDateTime.add(const Duration(minutes: 10));
    notifyListeners();
  }

  void setEndDateTime(DateTime newDateTime) {
    _endDateTime = newDateTime;
    notifyListeners();
  }

  Future<void> setMemberList(List<String> value) async {
    _addMemberFieldText = '';
    _selectedMember.clear();
    _selectedMember = value;
    log(_selectedMember.toString(), name: '_selectedMember');
    for (var element in _selectedMember) {
      final String name = _memberList[element] as String;
      _addMemberFieldText = '$name, $_addMemberFieldText';
    }
    notifyListeners();

    //log(_selectedMember.toString(), name: 'setMemberList');
    await router.pop();
  }

  Future<void> addEventIntoCalendar(Map<String, dynamic>? data) async {
    if (data != null) {
      setBusy(true);
      log(_selectedMember.toString());
      for (String calId in _selectedMember) {
        final String summary = data['title'] as String;
        final String description = data['description'] as String;
        //  String? location = data['localtion'] as String?;
        final Event request = Event(
            summary: summary,
            description: description,
            location: _selectedPlace,
            start: EventDateTime(dateTime: _startDateTime),
            end: EventDateTime(dateTime: _endDateTime));
       final Event response = await gCalApi.events.insert(request, calId);

        log(response.toJson().toString(), name: 'EventResponse');
      }

      await ref.read(homeScreenProvider.notifier).init();
      setBusy(false);
      await router.pop();
    }
  }
}
