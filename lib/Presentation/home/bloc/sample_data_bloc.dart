import 'package:basic_architecture/App/app_preferences.dart';
import 'package:basic_architecture/Domain/models/sample_data.dart';
import 'package:basic_architecture/Domain/usecase/detail_load_sample_data_usecase.dart';
import 'package:basic_architecture/Domain/usecase/load_sample_data_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'sample_data_event.dart';
part 'sample_data_state.dart';

@injectable
class SampleDataBloc extends Bloc<SampleDataEvent, SampleDataState> {
  final AppPreferences _appPreferences;
  final LoadSampleDataUseCase _loadSampleDataUsecase;
  final DetailLoadSampleDataUseCase _detailLoadSampleDataUsecase;

  SampleDataBloc(this._appPreferences, this._loadSampleDataUsecase,
      this._detailLoadSampleDataUsecase)
      : super(const LoadingState()) {
    on<GetSampleDataListEvent>(_onGetSampleDataListEvent);
    on<GetDetailSampleDataEvent>(
        (event, emit) => _onGetDetailSampleDataEvent(event.id, emit));
  }

  Future<void> _onGetSampleDataListEvent(
    GetSampleDataListEvent event,
    Emitter<SampleDataState> emit,
  ) async {
    // 데이터 요청중
    emit(const LoadingState());

    // 임의로 2초 딜레이
    await Future.delayed(const Duration(seconds: 2));

    var sampleDataList = await _loadSampleDataUsecase.execute(null);
    sampleDataList.fold(
      (left) => emit(const ErrorState()),
      (right) => {
        if (right.isEmpty)
          {emit(const EmptyDataState())}
        else
          {emit(LoadedState(right))}
      },
    );
  }

  Future<void> _onGetDetailSampleDataEvent(
      int id, Emitter<SampleDataState> emit) async {
    // 데이터 요청중
    emit(const DetailFetechingState());

    // 임의로 2초 딜레이
    await Future.delayed(const Duration(seconds: 2));

    var sampleDataList = await _detailLoadSampleDataUsecase.execute(id);
    sampleDataList.fold(
      (left) => emit(const DetailErrorState()),
      (right) => emit(DetailLoadedState(right)),
    );
  }
}
