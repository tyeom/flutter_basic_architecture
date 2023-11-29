part of 'subscription_info_bloc.dart';

enum DataLoadStatus {
  // 데이터 없음
  empty,
  // 로딩중
  loading,
  // 데이터 요청 오류
  error,
  // 로드 완료
  loaded,
}

abstract class SubscriptionInfoState extends Equatable {
  final DataLoadStatus status;
  final SubscriptionKey? subscriptionKeyInfo;

  const SubscriptionInfoState(this.status, {this.subscriptionKeyInfo});

  @override
  List<Object?> get props => [status, subscriptionKeyInfo];
}

/// 데이터 없음
class EmptyDataState extends SubscriptionInfoState {
  const EmptyDataState() : super(DataLoadStatus.empty);
}

/// 데이터 요청중
class LoadingState extends SubscriptionInfoState {
  const LoadingState() : super(DataLoadStatus.loading);
}

/// 데이터 요청 오류
class ErrorState extends SubscriptionInfoState {
  const ErrorState() : super(DataLoadStatus.error);
}

/// 로드 완료
class LoadedState extends SubscriptionInfoState {
  final SubscriptionKey? _subscriptionKey;
  const LoadedState(this._subscriptionKey)
      : super(DataLoadStatus.loaded, subscriptionKeyInfo: _subscriptionKey);
}
