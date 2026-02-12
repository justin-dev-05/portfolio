abstract class ApiState {
  bool get isLoading;
  bool get isSuccess;
  bool get isFailure;
  String? get errorMessage;
}

// enum ApiStatus { initial, loading, success, failure }

// class ApiState<T> {
//   final ApiStatus status;
//   final T data;
//   final String? errorMessage;

//   const ApiState({
//     this.status = ApiStatus.initial,
//     required this.data,
//     this.errorMessage,
//   });

//   bool get isLoading => status == ApiStatus.loading;
//   bool get isSuccess => status == ApiStatus.success;
//   bool get isFailure => status == ApiStatus.failure;

//   ApiState<T> copyWith({ApiStatus? status, T? data, String? errorMessage}) {
//     return ApiState(
//       status: status ?? this.status,
//       data: data ?? this.data,
//       errorMessage: errorMessage ?? this.errorMessage,
//     );
//   }
// }
