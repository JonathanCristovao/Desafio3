import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:socialmidia/data/firebase/firebase.dart';
import 'package:socialmidia/data/http/http.dart';
import 'package:socialmidia/domain/entities/entities.dart';
import 'package:socialmidia/domain/repository/repository.dart';
import 'package:socialmidia/ui/pages/pages.dart';

class GetxHomePresenter extends GetxController implements HomePresenter {
  final AddUser addUser;
  final FirebaseAuthentication firebaseAuthentication;
  final LoadPeople loadPeople;
  final LoadUsers loadUsers;

  GetxHomePresenter({
    required this.addUser,
    required this.firebaseAuthentication,
    required this.loadPeople,
    required this.loadUsers,
  });

  final Rx<List<PersonEntity>> _people = Rx<List<PersonEntity>>([]);

  @override
  Stream<List<PersonEntity>> get peopleStream => _people.stream;

  @override
  Future<void> loadPersons() async {
    try {
      final List<PersonEntity> people = await loadPeople.loadPeople();
      _people.subject.add(people);
    } on HttpError catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await firebaseAuthentication.logout();
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<void> remoteAddUser({required String name}) async {
    await addUser.addUser(
      user: PersonEntity(
        id: '0',
        name: name,
      ),
    );
  }

  @override
  Future<void> remoteLoadUsers() async {
    final people = await loadUsers.loadUsers();
    _people.subject.add(people);
  }
}
