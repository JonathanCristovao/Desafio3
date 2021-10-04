import 'package:socialmidia/presentation/presenters/presenter.dart';
import '../../../../ui/pages/pages.dart';
import '../../factories.dart';
import '../pages.dart';

LoginPresenter makeGetxLoginPresenter() => GetxLoginPresenter(
      firebaseAuthentication: makeFirebaseAuthenticationAdapter(),
      validation: makeLoginValidation(),
    );
