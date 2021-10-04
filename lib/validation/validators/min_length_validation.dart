import 'package:equatable/equatable.dart';
import 'package:socialmidia/presentation/protocols/protocols.dart';
import 'package:socialmidia/validation/protocols/protocols.dart';

class MinLengthValidation extends Equatable implements FieldValidation {
  @override
  final String field;
  final int size;

  const MinLengthValidation({required this.field, required this.size});

  @override
  ValidationError validate(Map input) =>
      input[field] != null && input[field].length >= size == true
          ? ValidationError.noError
          : ValidationError.invalidField;

  @override
  List<Object> get props => [field, size];
}
