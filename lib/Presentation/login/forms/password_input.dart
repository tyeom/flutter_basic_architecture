import 'package:formz/formz.dart';

class PasswordInput extends FormzInput<String, String> {
  const PasswordInput.pure() : super.pure('');

  const PasswordInput.dirty(String value) : super.dirty(value);

  @override
  String? validator(String value) {
    if (value.isEmpty) return 'Please enter your password.';
  }
}
