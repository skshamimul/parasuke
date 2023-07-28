import 'package:get_it/get_it.dart';
import '../router/app_route.dart';
import 'bottom_sheet_service.dart';
import 'file_picker_service.dart';

final GetIt getIt = GetIt.instance;

class ServiceHook {
  void setup() {
    getIt.registerSingleton<AppRouter>(AppRouter());
    getIt.registerLazySingleton<FilePickerService>(FilePickerService.new);
    getIt.registerLazySingleton<BottomSheetService>(BottomSheetService.new);
  }
}
