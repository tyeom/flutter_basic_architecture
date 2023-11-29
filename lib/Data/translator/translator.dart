import 'package:basic_architecture/Data/responses/authentication_response.dart';
import 'package:basic_architecture/Data/responses/member_response.dart';
import 'package:basic_architecture/Data/responses/sample_data_response.dart';
import 'package:basic_architecture/Data/responses/subscription_key_response.dart';
import 'package:basic_architecture/Domain/models/authentication.dart';
import 'package:basic_architecture/Domain/models/member_info.dart';
import 'package:basic_architecture/Domain/models/sample_data.dart';
import 'package:basic_architecture/Domain/models/subscription_key.dart';

/// Data entity -> Domain model 변환
extension AuthenticationResponseTranslator on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(this!.token, this!.expiration);
  }
}

extension MemberResponseTranslator on MemberResponse? {
  MemberInfo toDomain() {
    return MemberInfo(this!.no, this!.id, this!.role, this!.name, this?.email,
        this?.tel, this?.subscriptionKeyNo);
  }
}

extension SampleDataResponseTranslator on SampleDataResponse? {
  SampleData toDomain() {
    return SampleData(this!.userId, this!.id, this!.title, this!.body);
  }
}

extension SampleDataResponseListTranslator on List<SampleDataResponse>? {
  List<SampleData> toDomainList() {
    return this?.map((response) => response.toDomain())?.toList() ?? [];
  }
}

extension SubscriptionKeyResponseTranslator on SubscriptionKeyResponse? {
  SubscriptionKey? toDomain() {
    if (this == null) return null;

    return SubscriptionKey(this!.key, this!.keyType, this!.startDT, this!.endDT,
        this!.createDT, this!.memo);
  }
}
