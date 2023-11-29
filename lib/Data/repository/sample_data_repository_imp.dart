import 'package:basic_architecture/Data/data_source/remote_data_source.dart';
import 'package:basic_architecture/Data/responses/sample_data_response.dart';
import 'package:basic_architecture/Domain/models/sample_data.dart';
import 'package:basic_architecture/Data/translator/translator.dart';
import 'package:basic_architecture/Domain/repository/sample_data_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SampleDataRepository)
class SampleDataRepositoryImp implements SampleDataRepository {
  final RemoteDataSource _remote;

  SampleDataRepositoryImp(this._remote);

  @override
  Future<Either<String, List<SampleData>>> getSampleData() async {
    try {
      final List<SampleDataResponse> response = await _remote.getSampleData();

      return Right(response.toDomainList());
    } on DioException catch (ex) {
      if (ex.response != null) {
        if (ex.response!.data != null) {
          return Left(ex.response!.data.toString());
        } else {
          return Left(ex.response!.statusMessage ?? '샘플 데이터 요청 - 서버 응답 오류 01');
        }
      } else {
        return Left(ex.message ?? '샘플 데이터 요청 - 서버 응답 오류 02');
      }
    } catch (ex) {
      return Left(ex.toString());
    }
  }

  @override
  Future<Either<String, SampleData>> getDetailSampleData(int id) async {
    try {
      final SampleDataResponse response = await _remote.getDetailSampleData(id);

      return Right(response.toDomain());
    } on DioException catch (ex) {
      if (ex.response != null) {
        if (ex.response!.data != null) {
          return Left(ex.response!.data.toString());
        } else {
          return Left(
              ex.response!.statusMessage ?? '상세 샘플 데이터 요청 - 서버 응답 오류 01');
        }
      } else {
        return Left(ex.message ?? '상세 샘플 데이터 요청 - 서버 응답 오류 02');
      }
    } catch (ex) {
      return Left(ex.toString());
    }
  }
}
