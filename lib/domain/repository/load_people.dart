import 'package:socialmidia/domain/entities/entities.dart';

abstract class LoadPeople {
  Future<List<PersonEntity>> loadPeople();
}
