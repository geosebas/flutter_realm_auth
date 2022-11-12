import 'package:flutter/material.dart';

import 'package:realm/realm.dart';

import './password_field.dart';
import 'main.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> with RestorationMixin {
  var email = '';
  var password = '';

  late FocusNode _email, _password;

  @override
  void initState() {
    super.initState();
    _email = FocusNode();
    _password = FocusNode();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
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

  final RestorableInt _autoValidateModeIndex = RestorableInt(AutovalidateMode.always.index);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey = GlobalKey<FormFieldState<String>>();

  void _handleSubmitted() async {
    final form = _formKey.currentState!;
    if (form.validate()) {
      form.save();
      var emailCred = Credentials.emailPassword(email, password);
      try {
        await app.logIn(emailCred);
      } on Exception catch (error) {
        print(error.toString());
        return;
      }
      if (!mounted) {
        return;
      }
      Navigator.pushNamed(context, '/');
    }
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
                    icon: Icon(Icons.email),
                    helperText: ' ',
                    labelText: "email",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) {
                    email = value ?? '';
                    _password.requestFocus();
                  },
                ),
                sizedBoxSpace,
                PasswordField(
                  restorationId: '${restorationId}_password_field',
                  textInputAction: TextInputAction.done,
                  focusNode: _password,
                  fieldKey: _passwordFieldKey,
                  maxLength: 20,
                  labelText: "password",
                  onSaved: (value) {
                    password = value ?? '';
                  },
                ),
                sizedBoxSpace,
                Center(
                  child: ElevatedButton(
                    onPressed: _handleSubmitted,
                    child: const Text("submit"),
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
