import 'package:flutter/foundation.dart';

import '../../ui/pages/pages.dart';

class PersonModel {
  final String name;
  final String email;
  final String createdAt;

  PersonModel({
    required this.name,
    required this.email,
    required this.createdAt,
  });
}

class StreamProfilePresenter implements ProfilePresenter {
  late ProfilePersonViewModel person;

  @override
  void loadPerson() {
    final PersonModel personModel = PersonModel(
      name: 'Gabriel',
      email: 'gabriel.arruda@usemobile.com',
      createdAt: '23/09/2021',
    );

    person = ProfilePersonViewModel(name: personModel.name);

    debugPrint('StreamProfilePresenter');
  }
}
