import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialmidia/infra/infra.dart';
import '../../../data/firebase/firebase.dart';

FirebaseCloudFirestore makeFirebaseFirestoreAdapter() =>
    FirebaseCloudFirestoreAdapter(
      firebaseFirestore: FirebaseFirestore.instance,
    );
