part of 'sample_data_bloc.dart';

@immutable
abstract class SampleDataEvent extends Equatable {
  @override
  List<Object> get props => [];
}

/// 데이터 로드 이벤트
final class GetSampleDataListEvent extends SampleDataEvent {}

/// 데이터 상세 보기 로드 이벤트
final class GetDetailSampleDataEvent extends SampleDataEvent {
  final int id;
  GetDetailSampleDataEvent(this.id);

  @override
  List<Object> get props => [id];
}
