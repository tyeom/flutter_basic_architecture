import 'package:basic_architecture/Domain/models/authentication.dart';
import 'package:basic_architecture/Domain/repository/authentication_repository.dart';
import 'package:basic_architecture/Domain/request/login_request.dart';
import 'package:basic_architecture/Domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutUseCase implements BaseUseCase<void, String> {
  final AuthenticationRepository _authenticationRepository;

  LogoutUseCase(this._authenticationRepository);

  @override
  Future<Either<String, String>> execute(void input) async {
    return await _authenticationRepository.logout();
  }
}
