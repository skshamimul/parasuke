import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'common_state.freezed.dart';

@freezed
abstract class CommonState with _$CommonState {
  const factory CommonState.initializing() = _AuthStateInitializing;
  const factory CommonState.loading() = _Loading;
  const factory CommonState.success(String msg) = _Success;
  const factory CommonState.error(String errorText) = _Error;
}
