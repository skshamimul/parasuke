
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../provider/base_controller.dart';
import '../../router/app_route.gr.dart';

final printCalendarProvider =
    ChangeNotifierProvider<PrintCalendarController>((ref) {
  return PrintCalendarController(ref);
});

class PrintCalendarController extends BaseController {
  PrintCalendarController(this.ref);
  final ChangeNotifierProviderRef ref;


  Future<void> navToPdfView(List<String> monthList)async {
   await router.push(PdfViewRoute(listMonth: monthList));
  }
}
