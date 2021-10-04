import 'package:equatable/equatable.dart';

class PersonEntity extends Equatable {
  final String id;
  final String name;

  const PersonEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [id, name];
}
