import 'package:socialmidia/presentation/protocols/protocols.dart';

abstract class FieldValidation {
  String get field;
  ValidationError validate(Map input);
}
