import 'package:flutter/material.dart';

class ChangePassPage extends StatefulWidget {
  final Function() changePassword;
  final Function(String) updatePassword;

  const ChangePassPage( {
    super.key,
    required this.changePassword,
    required this.updatePassword
  });

  @override
  _ChangePassPageState createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {
  bool isPasswordHidden = true;
  final TextEditingController _forgotPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String password = "";
  IconData passIcon = Icons.visibility;

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
  void _updatePassword(String value) {
    setState(() {
      password = value;
      widget.updatePassword(value);
    });
    debugPrint(password);
  }

  bool _isPasswordValid(String password) {
    final RegExp passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d).{6,}$');
    return passwordRegex.hasMatch(password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Смена пароля'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Введите новый пароль',
              textAlign: TextAlign.center,
              textScaler: TextScaler.linear(1.2),
            ),
            const SizedBox(height: 16.0),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _forgotPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Пароль',
                      suffixIcon: IconButton(
                        icon: Icon(passIcon),
                        onPressed: () {
                          updatePasswordVisibility();
                        },
                      ),
                      errorText: password.isNotEmpty &&
                          (password.length < 6 || !_isPasswordValid(password))
                          ? 'Пароль должен содержать не менее 6 символов и не менее 1 буквы или 1 цифры.'
                          : null,
                      errorMaxLines: 2,
                    ),
                    obscureText: isPasswordHidden,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.left,
                    textDirection: TextDirection.ltr,
                    onChanged: (value) {
                      setState(() {
                        _updatePassword(value);
                        debugPrint(password);
                      });
                    },
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Пароль обязателен для заполнения';
                      }
                      if (value!.length < 6 || !_isPasswordValid(value)) {
                        return 'Пароль должен содержать не менее 6 символов и не менее 1 буквы или 1 цифры.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  ElevatedButton(
                    onPressed: _formKey.currentState?.validate() == true
                        ? () {
                      Navigator.of(context).pop();
                      widget.changePassword();
                    }
                        : null,
                    child: Text('Отправить'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
