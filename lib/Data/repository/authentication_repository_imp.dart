import 'package:basic_architecture/Data/data_source/remote_data_source.dart';
import 'package:basic_architecture/Data/network/auth_token_dio_interceptor.dart';
import 'package:basic_architecture/Data/responses/authentication_response.dart';
import 'package:basic_architecture/Domain/models/authentication.dart';
import 'package:basic_architecture/Domain/repository/authentication_repository.dart';
import 'package:basic_architecture/Domain/request/login_request.dart';
import 'package:basic_architecture/Domain/request/register_request.dart';
import 'package:basic_architecture/Data/translator/translator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthenticationRepository)
class AuthenticationRepositoryImp implements AuthenticationRepository {
  final RemoteDataSource _remote;

  AuthenticationRepositoryImp(this._remote);

  @override
  Future<Either<String, String>> forgotPassword(String id) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<String, Authentication>> login(
      LoginRequest loginRequest) async {
    try {
      final AuthenticationResponse response = await _remote.login(loginRequest);
      // if (response.status == 200) {
      //   return Right(response.toDomain());
      // } else {
      //   return Left(response.message ?? '인증 요청 - 서버 응답 오류 01');
      // }
      var authentication = response.toDomain();

      const storage = FlutterSecureStorage();
      await storage.write(key: ACCESS_TOKEN_KEY, value: authentication.token);

      return Right(authentication);
    } on DioException catch (ex) {
      if (ex.response != null) {
        if (ex.response!.data != null) {
          return Left(ex.response!.data.toString());
        } else {
          return Left(ex.response!.statusMessage ?? '인증 요청 - 서버 응답 오류 01');
        }
      } else {
        return Left(ex.message ?? '인증 요청 - 서버 응답 오류 02');
      }
    } catch (ex) {
      return Left(ex.toString());
    }
  }

  @override
  Future<Either<String, String>> logout() async {
    try {
      await _remote.logout();
      return const Right('sucess');
    } on DioException catch (ex) {
      if (ex.response != null) {
        if (ex.response!.data != null) {
          return Left(ex.response!.data.toString());
        } else {
          return Left(ex.response!.statusMessage ?? '인증 요청 - 서버 응답 오류 01');
        }
      } else {
        return Left(ex.message ?? '인증 요청 - 서버 응답 오류 02');
      }
    } catch (ex) {
      return Left(ex.toString());
    }
  }

  @override
  Future<Either<String, Authentication>> register(
      RegisterRequest registerRequest) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
