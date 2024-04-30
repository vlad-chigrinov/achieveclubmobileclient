import 'package:achieveclubmobileclient/main.dart';
import 'package:achieveclubmobileclient/registerpage.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function() loginCallback;
  final Function() registerCallback;
  final Function(String) updateEmail;
  final Function(String) updatePassword;
  final Function(String) updateFirstName;
  final Function(String) updateLastName;
  final Function(int) updateClubId;
  final Function(BuildContext) uploadAvatar;

  const LoginPage({
    Key? key,
    required this.loginCallback,
    required this.registerCallback,
    required this.updateEmail,
    required this.updatePassword,
    required this.updateFirstName,
    required this.updateLastName,
    required this.updateClubId,
    required this.uploadAvatar,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool isPasswordHidden = true;
  IconData passIcon = Icons.visibility;

  void navigateToRegisterPage(BuildContext context) {
    email = '';password = '';firstName = '';lastName = '';
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterPage(
          registerCallback: widget.registerCallback,
          updateEmail: widget.updateEmail,
          updatePassword: widget.updatePassword,
          updateFirstName: widget.updateFirstName,
          updateLastName: widget.updateLastName,
          updateClubId: widget.updateClubId,
          uploadAvatar: widget.uploadAvatar,
        ),
      ),
    );
  }

  void updatePasswordVisibility() {
    setState(() {
      isPasswordHidden = !isPasswordHidden;
      switch (passIcon) {
        case Icons.visibility_off:
          passIcon = Icons.visibility;
          break;
        case Icons.visibility:
          passIcon = Icons.visibility_off;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16.0),
            TextField(
              //controller: _emailController,
              controller: TextEditingController.fromValue(
                TextEditingValue(
                  text: email,
                  selection: TextSelection.collapsed(offset: email.length),
                ),
              ),
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              keyboardType: TextInputType.text,
              textAlign: TextAlign.left,
              textDirection: TextDirection.ltr,
              onChanged: (value) {
                widget.updateEmail(value);
              },
            ),
            const SizedBox(height: 16.0),
            TextField(
              //controller: _passwordController,
              controller: TextEditingController.fromValue(
                TextEditingValue(
                  text: password,
                  selection: TextSelection.collapsed(offset: password.length),
                ),
              ),
              decoration: InputDecoration(
                labelText: 'Пароль',
                suffixIcon: IconButton(
                  icon: Icon(passIcon),
                  onPressed: () {
                    updatePasswordVisibility();
                  },
                ),
              ),
              obscureText: isPasswordHidden,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.left,
              textDirection: TextDirection.ltr,
              onChanged: (value) {
                widget.updatePassword(value);
              },
            ),
            const SizedBox(height: 24.0),
            SizedBox(
              width: 150.0,
              height: 50.0,
              child: ElevatedButton(
                onPressed: widget.loginCallback,
                child: const Text('Войти', textAlign: TextAlign.center),
              ),
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                navigateToRegisterPage(context);
              },
              child: const Text('Зарегистрироваться', textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}