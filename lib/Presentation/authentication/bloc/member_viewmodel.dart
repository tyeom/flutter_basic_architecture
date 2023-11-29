import 'package:equatable/equatable.dart';

/// Presentation의 View에서 Domain 계층의 model 정보를 모두 사용하지 않기 위해
/// 별도의 ViewModel을 정의하여 해당 View에서만 사용.

/// To avoid using all model information of the domain layer in the presentation view
/// Define a separate ViewModel and use it only in that View.
class MemberViewModel extends Equatable {
  final int no;
  final String id;
  final String? name;
  final String? email;
  final String? tel;
  final int? subscriptionKey;

  const MemberViewModel(
      {required this.no,
      required this.id,
      required this.name,
      required this.email,
      required this.tel,
      this.subscriptionKey});

  @override
  List<Object?> get props => [no, id, name, email, tel, subscriptionKey];
}
