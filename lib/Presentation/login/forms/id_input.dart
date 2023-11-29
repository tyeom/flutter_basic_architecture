import 'package:formz/formz.dart';

class IDInput extends FormzInput<String, String> {
  const IDInput.pure() : super.pure('');

  const IDInput.dirty(String value) : super.dirty(value);

  @override
  String? validator(String value) {
    if (value.isEmpty || value.length < 2) return 'Please enter your ID.';
  }
}
