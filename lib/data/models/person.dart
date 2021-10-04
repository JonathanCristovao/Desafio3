import 'package:socialmidia/domain/entities/entities.dart';

class RemotePersonModel {
  final String id;
  final String name;

  RemotePersonModel({
    required this.id,
    required this.name,
  });

  factory RemotePersonModel.fromJson(Map<String, dynamic> json) =>
      RemotePersonModel(
        id: (json['id'] ?? '').toString(),
        name: (json['name'] ?? '').toString(),
      );

  factory RemotePersonModel.fromEntity(PersonEntity entity) =>
      RemotePersonModel(
        id: entity.id,
        name: entity.name,
      );

  PersonEntity toEntity() => PersonEntity(
        id: id,
        name: name,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}
