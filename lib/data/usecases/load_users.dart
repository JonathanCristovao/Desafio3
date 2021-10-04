import 'package:socialmidia/domain/entities/entities.dart';

abstract class LoadUsers {
  Future<List<PersonEntity>> loadUsers();
}
