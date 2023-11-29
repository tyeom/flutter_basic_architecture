import 'package:basic_architecture/Domain/models/authentication.dart';
import 'package:basic_architecture/Domain/request/login_request.dart';
import 'package:basic_architecture/Domain/request/register_request.dart';
import 'package:dartz/dartz.dart';

abstract class AuthenticationRepository{
  Future<Either<String,Authentication>> login(LoginRequest loginRequest);
  Future<Either<String,String>> logout();
  Future<Either<String,String>> forgotPassword(String id);
  Future<Either<String,Authentication>> register(RegisterRequest registerRequest);
}