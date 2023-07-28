import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googleapis/calendar/v3.dart';

import 'package:googleapis_auth/googleapis_auth.dart';
import '../../provider.dart';
import '../../router/app_route.dart';
import '../../service/setup_services.dart';
import '../../state/common_state.dart';
import '../home/controllers/home_controller.dart';

final eventProvider =
    StateNotifierProvider.autoDispose<EventNotifier, CommonState>((ref) {
  return EventNotifier(ref)..init();
});

class EventNotifier extends StateNotifier<CommonState> {
  final StateNotifierProviderRef ref;
  EventNotifier(this.ref) : super(const CommonState.initializing());
  late CalendarApi gCalApi;
  final AppRouter router = getIt<AppRouter>();

  Future<void> init() async {
    final AuthClient? authClient = ref.read(authServiceProvider).authClient;
    assert(authClient != null, 'Authenticated client missing!');

    gCalApi = CalendarApi(authClient!);
  }

  Future<void> addEventIntoCalendar(
      Map<String, dynamic>? data,
      List<String> selectedMember,
      String selectedPlace,
      DateTime startDateTime,
      DateTime endDateTime) async {
    state = const CommonState.loading();
    if (data != null) {
      for (String calId in selectedMember) {
        final String summary = data['title'] as String;
        final String description = data['description'] as String;
        //  String? location = data['localtion'] as String?;
       // log('${startDateTime}', name: 'startDateTime');
        //log('${endDateTime}', name: 'endDateTime');
        final Event request = Event(
            summary: summary,
            description: description,
            location: selectedPlace,
            start: EventDateTime(
              dateTime: startDateTime,
            ),
            end: EventDateTime(
              dateTime: endDateTime,
            ));
        final Event response = await gCalApi.events.insert(request, calId);

        log(response.toJson().toString(), name: 'EventResponse');
      }

      await ref
          .read(homeScreenProvider.notifier)
          .init()
          .then((value) => state = const CommonState.success('Success'));
    }
  }

  void navToPop() {
    router.pop();
  }
}
