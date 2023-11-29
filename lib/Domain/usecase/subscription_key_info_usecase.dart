import 'package:basic_architecture/Domain/models/subscription_key.dart';
import 'package:basic_architecture/Domain/repository/member_repository.dart';
import 'package:basic_architecture/Domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class SubscriptionKeyInfoUseCase implements BaseUseCase<void, SubscriptionKey?> {
  final MemberRepository _memberRepository;

  SubscriptionKeyInfoUseCase(this._memberRepository);

  @override
  Future<Either<String, SubscriptionKey?>> execute(void input) async {
    return await _memberRepository.getSubscriptionKeyInfo();
  }
}
