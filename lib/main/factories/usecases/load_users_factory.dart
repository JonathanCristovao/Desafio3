import 'package:socialmidia/core/usecases/usecases.dart';
import '../../../data/usecases/usecases.dart';

import '../factories.dart';

LoadUsers makeRemoteLoadUsers() => RemoteLoadUsers(
      cloudFirestore: makeFirebaseFirestoreAdapter(),
    );
