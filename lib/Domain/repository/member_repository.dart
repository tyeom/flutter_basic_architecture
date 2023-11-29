import 'package:basic_architecture/Domain/models/member_info.dart';
import 'package:basic_architecture/Domain/models/subscription_key.dart';
import 'package:dartz/dartz.dart';

abstract class MemberRepository {
  Future<Either<String, MemberInfo>> getMemberInfo();
  Future<Either<String, SubscriptionKey?>> getSubscriptionKeyInfo();
}
