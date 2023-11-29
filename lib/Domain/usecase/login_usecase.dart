import 'package:basic_architecture/Domain/models/authentication.dart';
import 'package:basic_architecture/Domain/repository/authentication_repository.dart';
import 'package:basic_architecture/Domain/request/login_request.dart';
import 'package:basic_architecture/Domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  final AuthenticationRepository _authenticationRepository;

  LoginUseCase(this._authenticationRepository);

  @override
  Future<Either<String, Authentication>> execute(
      LoginUseCaseInput input) async {
    return await _authenticationRepository
        .login(LoginRequest(input.id, input.password));
  }
}

class LoginUseCaseInput {
  String id;
  String password;
  LoginUseCaseInput(this.id, this.password);
}
