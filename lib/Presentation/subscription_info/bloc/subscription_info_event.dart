part of 'subscription_info_bloc.dart';

@immutable
abstract class SubscriptionInfoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class GetSubscriptionInfoEvent extends SubscriptionInfoEvent {}
