enum ResetPasswordStatus { initial, loading, success, failure }

class ResetPasswordState {
  final ResetPasswordStatus status;
  final String? errorMessage;

  const ResetPasswordState({this.status = ResetPasswordStatus.initial, this.errorMessage});

  ResetPasswordState copyWith({ResetPasswordStatus? status, String? errorMessage}) {
    return ResetPasswordState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}