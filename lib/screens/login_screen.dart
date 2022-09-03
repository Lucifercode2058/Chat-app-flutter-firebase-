import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool spinner = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/9e2e3b57992c4390f6f963f838b5b896.gif'),
          fit: BoxFit.fill,
        )
      ),
      child: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Scaffold(
          backgroundColor: Colors.transparent,

          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextField(
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400
                  ),
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: beautify.copyWith(helperText: '',hintStyle: TextStyle(color: Colors.teal,fontWeight: FontWeight.w400)),),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                    textAlign: TextAlign.center,
                    obscureText: true,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration:
                        beautify.copyWith(hintText: 'Enter your password',hintStyle: TextStyle(color: Colors.teal,fontWeight: FontWeight.w400))),
                SizedBox(
                  height: 24.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    elevation: 5.0,
                    child: MaterialButton(
                      onPressed: () async {
                        try {
                          setState(() {
                            spinner = true;
                          });
                          final login = await _auth.signInWithEmailAndPassword(
                              email: email, password: password);
                          if (login != null) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ChatScreen();
                            }));
                          }
                        } catch (e) {
                          print(e);
                        }
                        setState(() {
                          spinner = false;
                        });
                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        'Log In',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
