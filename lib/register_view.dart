import 'package:flutter/material.dart';

import 'package:realm/realm.dart';

import 'main.dart';
import 'password_field.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  RegisterViewState createState() => RegisterViewState();
}

class RegisterViewState extends State<RegisterView> with RestorationMixin {
  var email = '';
  var password = '';

  late FocusNode _email, _password, _retypePassword;

  @override
  void initState() {
    super.initState();
    _email = FocusNode();
    _password = FocusNode();
    _retypePassword = FocusNode();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _retypePassword.dispose();
    super.dispose();
  }

  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(value),
    ));
  }

  @override
  String get restorationId => 'register_view_form';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_autoValidateModeIndex, '${restorationId}autovalidate_mode');
  }

  final RestorableInt _autoValidateModeIndex = RestorableInt(AutovalidateMode.onUserInteraction.index);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey = GlobalKey<FormFieldState<String>>();

  void _handleSubmitted() async {
    final form = _formKey.currentState!;
    if (form.validate()) {
      form.save();
      // var app = locator<RealmApp>().app;

      var authProvider = app.emailPasswordAuthProvider;
      // ignore: unnecessary_brace_in_string_interps
      print("username :  $email  && password : $password");
      try {
        await authProvider.registerUser(email, password);
      } on RealmException catch (error) {
        print(error.message);
        return;
      }
      if (!mounted) {
        return;
      }
      Navigator.pushNamed(context, 'login');
    }
  }

  String? _validatePassword(String? value) {
    final passwordField = _passwordFieldKey.currentState!;
    if (passwordField.value == null || passwordField.value!.isEmpty) {
      return "Please enter password";
    }
    if (passwordField.value != value) {
      return "Do not match";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    const sizedBoxSpace = SizedBox(height: 24);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: const BackButton(color: Colors.black),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.values[_autoValidateModeIndex.value],
        child: Scrollbar(
          child: SingleChildScrollView(
            restorationId: '${restorationId}_scroll_view',
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                sizedBoxSpace,
                TextFormField(
                  restorationId: '${restorationId}_email_field',
                  textInputAction: TextInputAction.next,
                  focusNode: _email,
                  decoration: const InputDecoration(
                    filled: true,
                    prefixIcon: Icon(Icons.email),
                    helperText: ' ',
                    labelText: "email",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) {
                    email = value ?? '';
                  },
                ),
                sizedBoxSpace,
                PasswordField(
                  restorationId: '${restorationId}_password_field',
                  textInputAction: TextInputAction.next,
                  focusNode: _password,
                  fieldKey: _passwordFieldKey,
                  maxLength: 20,
                  labelText: "password",
                  icon: const Icon(Icons.lock),
                  onSaved: (value) {
                    password = value ?? '';
                  },
                ),
                sizedBoxSpace,
                PasswordField(
                  restorationId: '${restorationId}_retype_password_field',
                  focusNode: _retypePassword,
                  textInputAction: TextInputAction.done,
                  labelText: "confirm password",
                  maxLength: 20,
                  validator: _validatePassword,
                  icon: const Icon(Icons.lock),
                  onFieldSubmitted: (value) {
                    _handleSubmitted();
                  },
                ),
                sizedBoxSpace,
                Center(
                  child: ElevatedButton(
                    onPressed: _handleSubmitted,
                    child: const Text("Submit"),
                  ),
                ),
                sizedBoxSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
