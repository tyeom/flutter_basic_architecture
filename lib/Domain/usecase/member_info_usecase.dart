import 'package:basic_architecture/Domain/models/member_info.dart';
import 'package:basic_architecture/Domain/repository/member_repository.dart';
import 'package:basic_architecture/Domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class MemberInfoUseCase implements BaseUseCase<void, MemberInfo?> {
  final MemberRepository _memberRepository;

  MemberInfoUseCase(this._memberRepository);

  @override
  Future<Either<String, MemberInfo?>> execute(void input) async {
    return await _memberRepository
        .getMemberInfo();
  }
}
