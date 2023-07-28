import 'package:flutter/foundation.dart';
import '../router/app_route.dart';
import '../service/bottom_sheet_service.dart';
import '../service/file_picker_service.dart';

import '../service/setup_services.dart';
import 'helpers/builders_helpers.dart';
import 'helpers/busy_error_state_helper.dart';

class BaseController extends ChangeNotifier
    with BuilderHelpers, BusyAndErrorStateHelper {
  final BottomSheetService bottomSheetService = getIt<BottomSheetService>();
  final FilePickerService picker = getIt<FilePickerService>();
  final AppRouter router = getIt<AppRouter>();

  @override
  void notifyListeners() {
    if (!disposed) {
      super.notifyListeners();
    }
  }

  /// Calls the builder function with this updated viewmodel
  void rebuildUi() {
    notifyListeners();
  }

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }
}
