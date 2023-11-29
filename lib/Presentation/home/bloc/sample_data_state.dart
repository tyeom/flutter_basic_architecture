part of 'sample_data_bloc.dart';

enum DataLoadStatus {
  // 데이터 없음
  empty,
  // 로딩중
  loading,
  // 상세 내용 요청중
  feteching,
  // 데이터 요청 오류
  error,
  // 상세 데이터 요청 오류
  detailError,
  // 로드 완료
  loaded,
  // 상세 데이터 로드 완료
  detailLoaded,
}

abstract class SampleDataState extends Equatable {
  final DataLoadStatus status;
  final List<SampleData>? sampleDataList;
  final SampleData? detailSampleData;

  const SampleDataState(this.status,
      {this.sampleDataList, this.detailSampleData});

  @override
  List<Object?> get props => [status, sampleDataList, detailSampleData];
}

/// 데이터 없음
class EmptyDataState extends SampleDataState {
  const EmptyDataState() : super(DataLoadStatus.empty);
}

/// 데이터 요청중
class LoadingState extends SampleDataState {
  const LoadingState() : super(DataLoadStatus.loading);
}

/// 데이터 요청 오류
class ErrorState extends SampleDataState {
  const ErrorState() : super(DataLoadStatus.error);
}

/// 로드 완료
class LoadedState extends SampleDataState {
  final List<SampleData> _sampleDataList;
  const LoadedState(this._sampleDataList)
      : super(DataLoadStatus.loaded, sampleDataList: _sampleDataList);
}

/// 상세 내용 데이터 요청중
class DetailFetechingState extends SampleDataState {
  const DetailFetechingState() : super(DataLoadStatus.feteching);
}

/// 상세 데이터 요청 오류
class DetailErrorState extends SampleDataState {
  const DetailErrorState() : super(DataLoadStatus.detailError);
}

/// 상세 내용 로드 완료
class DetailLoadedState extends SampleDataState {
  final SampleData _detailSampleData;
  const DetailLoadedState(this._detailSampleData)
      : super(DataLoadStatus.detailLoaded, detailSampleData: _detailSampleData);
}
