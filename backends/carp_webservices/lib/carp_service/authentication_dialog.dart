/*
 * Copyright 2021 Copenhagen Center for Health Technology (CACHET) at the
 * Technical University of Denmark (DTU).
 * Use of this source code is governed by a MIT-style license that can be
 * found in the LICENSE file.
 */
part of carp_services;

/// A modal dialog shown to the user to input username and password.
class AuthenticationDialog {
  var _usernameKey = GlobalKey<FormFieldState>();
  var _passwordKey = GlobalKey<FormFieldState>();
  String get _username => _usernameKey.currentState?.value?.trim();
  String get _password => _passwordKey.currentState?.value?.trim();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Alert build(context, {String username}) => Alert(
          context: context,
          title: "LOGIN",
          content: Form(
              key: _formkey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    key: _usernameKey,
                    initialValue: username,
                    maxLines: 1,
                    keyboardType: TextInputType.emailAddress,
                    validator: MultiValidator([
                      RequiredValidator(errorText: "* Required"),
                      CARPEmailValidator(errorText: "Enter valid email."),
                    ]),
                    decoration: InputDecoration(
                      icon: Icon(Icons.account_circle),
                      labelText: 'Username',
                      hintText: 'Enter email as abc@cachet.dk',
                    ),
                  ),
                  TextFormField(
                    key: _passwordKey,
                    validator: MultiValidator([
                      RequiredValidator(errorText: "* Required"),
                      MinLengthValidator(8,
                          errorText: "At least 8 characters."),
                    ]),
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: 'Password',
                      hintText: 'Enter password',
                    ),
                  ),
                ],
              )),
          buttons: [
            DialogButton(
              onPressed: () async {
                try {
                  await CarpService()
                      .authenticate(username: _username, password: _password);
                  Navigator.pop(context);
                } catch (exception) {
                  warning(
                      'Exception in authentication via dialog - $exception');
                }
              },
              color: Colors.blue[900],
              child: Text(
                "Sign in with CARP",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ]);
}
