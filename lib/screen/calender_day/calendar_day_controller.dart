import 'dart:async';
import 'dart:developer';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/base_controller.dart';
import '../home/controllers/home_controller.dart';
import 'model/event.dart';

final calendarDayProvider =
    ChangeNotifierProvider<CalendarDayController>((ref) {
  Map<String, dynamic> calInfo = ref.read(homeScreenProvider.notifier).calInfo;
  return CalendarDayController(ref,calInfo)..init();
});

class CalendarDayController extends BaseController {
  CalendarDayController(this.ref, this.calInfo);
  final ChangeNotifierProviderRef ref;
  final Map<String, dynamic> calInfo;

  List<CalendarEventData<Event>> _events = [];

  List<CalendarEventData<Event>> get events => _events;

  Future<void> init() async {
    setBusy(true);
  }
}
