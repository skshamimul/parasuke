import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/src/auth_client.dart';

import '../../../provider.dart';
import '../../../provider/base_controller.dart';
import '../../../repository/profile/data/profile_repo.dart';
import '../../../repository/profile/domain/profile_model.dart';
import '../../../router/app_route.gr.dart';
import '../../../widget/utils/app_function.dart';

final ChangeNotifierProvider<HomeScreenController> homeScreenProvider =
    ChangeNotifierProvider<HomeScreenController>(
        (ChangeNotifierProviderRef<HomeScreenController> ref) {
  return HomeScreenController(ref)..init();
});

class HomeScreenController extends BaseController {
  HomeScreenController(this.ref);
  final ChangeNotifierProviderRef ref;

  List<CalendarListEntry> _calendarList = [];
  List<CalendarListEntry> get calendarList => _calendarList;
  final List<Map<String, dynamic>?> _eventList = [];
  List<Map<String, dynamic>?> get eventList => _eventList;
  Map<String, dynamic> _calInfo = {};
  Map<String, dynamic> get calInfo => _calInfo;

  List<List<List<Map<String, dynamic>>>> _cananderData = [];
  List<List<List<Map<String, dynamic>>>> get cananderData => _cananderData;

  late DateTime _selectedStarDate;
  late DateTime _selectedEndDate;

  Profile? _profile;
  Profile? get profile => _profile;

  List<double> _rowHeightsList = [];
  List<double> get rowHeightsList => _rowHeightsList;

  Future<void> init() async {
    setBusy(true);
    _eventList.clear();
    _cananderData.clear();
    _calendarList.clear();

    final DateTime today = DateTime.now();
    final int daysInMonth = DateUtils.getDaysInMonth(today.year, today.month);

    _selectedStarDate = DateTime(today.year, today.month, 1);
    _selectedEndDate = DateTime(today.year, today.month, daysInMonth);

    final User? currentUser = ref.read(authServiceProvider).currentUser;
    final AuthClient? authClient = ref.read(authServiceProvider).authClient;
    if (currentUser == null) {
      throw AssertionError("User can't be null");
    }

    final ProfilesRepo repository = ref.read(profilesRepoProvider);
    final Profile? profile =
        await repository.fetchProfile(uid: currentUser.uid);

    if (profile != null) {
      log(profile.toMap().toString(), name: 'profile');
      _profile = profile;
      // if (_profile != null) {
      //   if (!_profile!.isNotNew) {
      //     await _router.push(FirstSignupRoute(profile: _profile!));
      //   }
      // }
    }

    assert(authClient != null, 'Authenticated client missing!');

    final CalendarApi gCalAPI = CalendarApi(authClient!);
    final CalendarList resultCalendarList = await gCalAPI.calendarList.list();
    for (var element in resultCalendarList.items!) {
      if (!element.id!.contains('@group.v.calendar.google.com')) {
        _calendarList.add(element);
      }
    }

    // final Channel channel00 =
    //     Channel(id: 'watchcalendarList', type: 'web_hook');

    // final watchcalendarList = await gCalAPI.calendarList.watch(channel00);

    // log(watchcalendarList.toString(), name: 'watchcalendarList');

    if (_calendarList != null) {
      for (final CalendarListEntry calender in _calendarList) {
        //log(calender.toJson().toString(), name: 'Calendar');
        final Events events = await gCalAPI.events.list(calender.id!,
            timeMin: _selectedStarDate, timeMax: _selectedEndDate);

        if (events.items != null) {
          for (final Event event in events.items!) {
            final Map<String, dynamic> eventMap = <String, dynamic>{
              'calId': calender.id,
              ...event.toJson()
            };
            _eventList.add(eventMap);
          }
        }
      }
    }
    log(_eventList.toString(), name: 'Event');
    final (x, y) = await compute(makeData,
        DataRecord(calendarList: _calendarList, eventList: _eventList));
    _cananderData = x;
    _rowHeightsList = y;

    setBusy(false);
  }

  Future<void> navToCalenderDetails(
      int date, String calenderID, List<Map<String, dynamic>> data) async {
    _calInfo.clear();
    final DateTime today = DateTime.now();
    final DateTime selectedDate = DateTime(today.year, today.month, date + 1);

    _calInfo = {'date': selectedDate, 'calenderId': calenderID};
    await router.push(CalendarDayRoute(
        date: selectedDate,
        calenderID: calenderID,
        events: data,
        titleColumn: List<String>.generate(
            _calendarList.length,
            (int i) =>
                _calendarList[i].summary!.replaceAll('@gmail.com', ''))));
  }
}

(
  List<List<List<Map<String, dynamic>>>> cananderData,
  List<double> rowHeightsList
) makeData(DataRecord record) {
  final List<List<List<Map<String, dynamic>>>> cananderData = [];
  List<double> rowHeightsList = [];
  final List<List<double>> _rowHeightsListOfList = [];
  final List<List<String>> output = [];
  final DateTime today = DateTime.now();
  final int daysInMonth = DateUtils.getDaysInMonth(today.year, today.month);
  if (record.calendarList != null) {
    for (int i = 0; i < record.calendarList.length; i++) {
      final String calenderId = record.calendarList[i].id!;
      final List<List<Map<String, dynamic>>> row = [];
      final List<double> heightList = [];
      if (record.eventList.isNotEmpty) {
        final List<Map<String, dynamic>> calenderEvent = [];
        for (int k = 0; k < record.eventList.length; k++) {
          final Map<String, dynamic> event0 = record.eventList[k]!;
          if (event0['calId'] == calenderId) {
            calenderEvent.add(event0);
          }
        }

        for (int j = 0; j < daysInMonth; j++) {
          final List<Map<String, dynamic>> des = [];
          if (calenderEvent.isNotEmpty) {
            for (int m = 0; m < calenderEvent.length; m++) {
              final Map<String, dynamic> event = calenderEvent[m];
              final EventDateTime eventDateTime =
                  event['start'] as EventDateTime;
              DateTime eventDate;
              if (eventDateTime.dateTime != null) {
                eventDate = eventDateTime.dateTime!;
              } else {
                eventDate = eventDateTime.date!;
              }

              final int day = eventDate.day - 1;
              if (day == j &&
                  eventDate.month == today.month &&
                  eventDate.year == today.year) {
                des.add(event);
              }
            }
            row.add(des);
          } else {
            row.add(des);
          }

          double height = des.length > 0.0 ? des.length * 40 : 40;
          heightList.add(height);
        }
      }
      _rowHeightsListOfList.add(heightList);
      cananderData.add(row);
    }

    rowHeightsList = getMaxValueList(_rowHeightsListOfList);
  }

  return (cananderData, rowHeightsList);
}

class DataRecord {
  final List<CalendarListEntry> calendarList;
  final List<Map<String, dynamic>?> eventList;

  DataRecord({required this.calendarList, required this.eventList});
}

// Future<List<Map<String, dynamic>?>> getEventList(CalendarApi gCalAPI) async {
//   final CalendarList resultCalendarList = await gCalAPI.calendarList.list();
//   return resultCalendarList;
// }
