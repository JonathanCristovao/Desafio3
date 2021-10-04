import 'package:get/get.dart';
import 'package:socialmidia/data/firebase/firebase.dart';
import 'package:socialmidia/presentation/protocols/protocols.dart';
import 'package:socialmidia/ui/pages/pages.dart';

class GetxLoginPresenter extends GetxController implements LoginPresenter {
  final FirebaseAuthentication firebaseAuthentication;
  final Validation validation;

  GetxLoginPresenter({
    required this.firebaseAuthentication,
    required this.validation,
  });

  String _email = '';
  String _password = '';

  Rx<String> emailError = Rx<String>('');
  Rx<String> passwordError = Rx<String>('');
  Rx<bool> isFormValid = Rx<bool>(false);
  Rx<String> userCredentialError = Rx<String>('');
  Rx<String> navigateTo = Rx<String>('');

  @override
  Stream<String> get emailErrorStream => emailError.stream;
  @override
  Stream<String> get passwordErrorStream => passwordError.stream;
  @override
  Stream<bool> get isFormValidStream => isFormValid.stream;
  @override
  Stream<String> get navigateToStream => navigateTo.stream;
  @override
  Stream<String> get userCredentialErrorStream => userCredentialError.stream;

  @override
  void validateEmail(String email) {
    _email = email;
    final String error = _validateField('email');
    emailError.subject.add(error);
    _validateForm();
  }

  @override
  void validatePassword(String password) {
    _password = password;
    final String error = _validateField('password');
    passwordError.subject.add(error);
    _validateForm();
  }

  void _validateForm() {
    isFormValid.subject.add(emailError.subject.value == '' &&
        passwordError.subject.value == '' &&
        _email.isNotEmpty &&
        _password.isNotEmpty);
  }

  String _validateField(String field) {
    final Map formData = {
      'email': _email,
      'password': _password,
    };
    final error = validation.validate(field: field, input: formData);
    switch (error) {
      case ValidationError.invalidField:
        return 'Campo inválido';
      case ValidationError.requiredField:
        return 'Campo obrigatório';
      case ValidationError.invalidEmail:
        return 'Email inválido';
      case ValidationError.noError:
        return '';
    }
  }

  @override
  Future<void> auth() async {
    try {
      await firebaseAuthentication.authWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      navigateTo.subject.add('/home');
    } on FirebaseAuthError catch (error) {
      userCredentialError.subject.add(error.name);
    }
  }
}
