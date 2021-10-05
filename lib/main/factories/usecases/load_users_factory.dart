import 'package:socialmidia/domain/repository/repository.dart';
import 'package:socialmidia/domain/usecases/usecases.dart';

import '../factories.dart';

LoadUsers makeRemoteLoadUsers() => RemoteLoadUsers(
      cloudFirestore: makeFirebaseFirestoreAdapter(),
    );
