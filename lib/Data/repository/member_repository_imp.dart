import 'package:basic_architecture/Data/data_source/remote_data_source.dart';
import 'package:basic_architecture/Data/responses/member_response.dart';
import 'package:basic_architecture/Data/responses/subscription_key_response.dart';
import 'package:basic_architecture/Domain/models/member_info.dart';
import 'package:basic_architecture/Domain/models/subscription_key.dart';
import 'package:basic_architecture/Domain/repository/member_repository.dart';
import 'package:basic_architecture/Data/translator/translator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: MemberRepository)
class MemberRepositoryImp implements MemberRepository {
  final RemoteDataSource _remote;

  MemberRepositoryImp(this._remote);

  @override
  Future<Either<String, MemberInfo>> getMemberInfo() async {
    try {
      final MemberResponse response = await _remote.getMemberInfo();
      // if (response.status == 200) {
      //   return Right(response.toDomain());
      // } else {
      //   return Left(response.message ?? '인증 요청 - 서버 응답 오류 01');
      // }

      return Right(response.toDomain());
    } on DioException catch (ex) {
      if (ex.response != null) {
        if (ex.response!.data != null) {
          return Left(ex.response!.data.toString());
        } else {
          return Left(ex.response!.statusMessage ?? '사용자 정보 요청 - 서버 응답 오류 01');
        }
      } else {
        return Left(ex.message ?? '사용자 정보 요청 - 서버 응답 오류 02');
      }
    } catch (ex) {
      return Left(ex.toString());
    }
  }

  @override
  Future<Either<String, SubscriptionKey?>> getSubscriptionKeyInfo() async {
    try {
      final SubscriptionKeyResponse? response =
          await _remote.getSubscriptionKeyResponse();

      return Right(response.toDomain());
    } on DioException catch (ex) {
      if (ex.response != null) {
        if (ex.response!.data != null) {
          return Left(ex.response!.data.toString());
        } else {
          return Left(ex.response!.statusMessage ?? '구독 키 정보 요청 - 서버 응답 오류 01');
        }
      } else {
        return Left(ex.message ?? '구독 키 정보 요청 - 서버 응답 오류 02');
      }
    } catch (ex) {
      return Left(ex.toString());
    }
  }
}
