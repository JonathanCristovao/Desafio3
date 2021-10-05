import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialmidia/data/firebase/firebase.dart';
import 'package:socialmidia/data/models/models.dart';
import 'package:socialmidia/domain/entities/entities.dart';
import 'package:socialmidia/domain/repository/repository.dart';

class RemoteAddUser implements AddUser {
  final FirebaseCloudFirestore cloudFirestore;

  RemoteAddUser({
    required this.cloudFirestore,
  });

  @override
  Future<void> addUser({required PersonEntity user}) async {
    final CollectionReference collectionReference =
        await cloudFirestore.getCollectionReference(collectionPath: 'users');
    collectionReference.add(RemotePersonModel.fromEntity(user).toJson());
  }
}
