import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialmidia/data/firebase/firebase.dart';
import 'package:socialmidia/domain/entities/entities.dart';
import 'package:socialmidia/domain/repository/repository.dart';

class RemoteLoadUsers implements LoadUsers {
  final FirebaseCloudFirestore cloudFirestore;

  RemoteLoadUsers({
    required this.cloudFirestore,
  });

  @override
  Future<List<PersonEntity>> loadUsers() async {
    final CollectionReference collectionReference =
        await cloudFirestore.getCollectionReference(collectionPath: 'users');
    final QuerySnapshot response = await collectionReference.get();
    final List<PersonEntity> people = response.docs.map(
      (document) {
        final Map<String, dynamic> data =
            document.data() as Map<String, dynamic>;
        return PersonEntity(
          id: document.id,
          name: (data['name'] ?? ''),
        );
      },
    ).toList();

    return people;
  }
}
