import 'package:socialmidia/domain/entities/entities.dart';

abstract class CommentPresenter {
  Stream<List<PersonEntity>> get peopleStream;

  Future<void> loadPersons();
  // Future<void> remoteAddComment({required String Comment});
  Future<void> remoteLoadUsers();
}
