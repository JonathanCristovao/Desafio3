import 'package:socialmidia/domain/repository/repository.dart';
import 'package:socialmidia/domain/usecases/remote_add_user.dart';
import '../factories.dart';

AddUser makeRemoteAddUser() => RemoteAddUser(
      cloudFirestore: makeFirebaseFirestoreAdapter(),
    );
