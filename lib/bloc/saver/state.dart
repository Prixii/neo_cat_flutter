import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class SaverState with _$SaverState {
  const factory SaverState({
    required bool isLoading,
  }) = _SaverState;

  factory SaverState.initial() {
    return const SaverState(
      isLoading: false,
    );
  }
}
