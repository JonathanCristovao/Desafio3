import 'package:firebase_auth/firebase_auth.dart';
import 'package:socialmidia/infra/infra.dart';

import '../../../data/firebase/firebase.dart';

FirebaseAuthentication makeFirebaseAuthenticationAdapter() =>
    FirebaseAuthenticationAdapter(
      firebaseAuth: FirebaseAuth.instance,
    );
