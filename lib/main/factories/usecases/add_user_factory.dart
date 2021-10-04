import 'package:socialmidia/core/usecases/usecases.dart';
import '../../../data/usecases/usecases.dart';
import '../factories.dart';

AddUser makeRemoteAddUser() => RemoteAddUser(
      cloudFirestore: makeFirebaseFirestoreAdapter(),
    );
