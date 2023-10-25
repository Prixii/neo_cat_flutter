import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class SaverState with _$SaverState {
  const factory SaverState({
    required bool isAlertVisible,
    required String alertMessage,
    required bool isLoading,
    required bool isNameConflict,
  }) = _SaverState;

  factory SaverState.initial() {
    return const SaverState(
        isAlertVisible: false,
        alertMessage: '',
        isLoading: false,
        isNameConflict: false);
  }
}
