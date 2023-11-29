import 'package:basic_architecture/App/app_preferences.dart';
import 'package:basic_architecture/Domain/models/subscription_key.dart';
import 'package:basic_architecture/Domain/usecase/subscription_key_info_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'subscription_info_event.dart';
part 'subscription_info_state.dart';

@injectable
class SubscriptionInfoBloc
    extends Bloc<SubscriptionInfoEvent, SubscriptionInfoState> {
  final AppPreferences _appPreferences;
  final SubscriptionKeyInfoUseCase _subscriptionKeyInfoUseCase;

  SubscriptionInfoBloc(this._appPreferences, this._subscriptionKeyInfoUseCase)
      : super(const LoadingState()) {
    on<GetSubscriptionInfoEvent>(_onGetSubscriptionInfoEvent);
  }

  Future<void> _onGetSubscriptionInfoEvent(
    GetSubscriptionInfoEvent event,
    Emitter<SubscriptionInfoState> emit,
  ) async {
    // 데이터 요청중
    emit(const LoadingState());

    // 임의로 1초 딜레이
    await Future.delayed(const Duration(seconds: 1));

    var subscriptionKeyInfo = await _subscriptionKeyInfoUseCase.execute(null);
    subscriptionKeyInfo.fold(
      (left) => emit(const ErrorState()),
      (right) => emit(LoadedState(right)),
    );
  }
}
