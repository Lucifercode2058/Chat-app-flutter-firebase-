import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override

  final _auth =FirebaseAuth.instance;
  String email;
  String password;
  bool spinner=false;
  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/giphy.gif'),
          fit: BoxFit.contain
        )
      ),
      child: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Scaffold(

          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: 100.0,
                  child: Image.asset('images/logo.png'),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextField(
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                   email=value;
                  },
                  decoration: beautify.copyWith(hintText: 'Enter your email',hintStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w500)),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  style: TextStyle(fontSize: 15),
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password=value;
                  },
                  decoration: beautify.copyWith(hintText: 'Enter your password',hintStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w500)),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    elevation: 5.0,
                    child: MaterialButton(
                      onPressed: () async {
                        print(email);
                        print(password);

                        try{
                          setState(() {
                            spinner=true;
                          });
                          final newuser =await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                          if (newuser != null) {
                            Navigator.push(context, MaterialPageRoute(builder: (
                                context) {
                              return ChatScreen();
                            }));
                          }
                          setState(() {
                            spinner=false;
                          });
                        }
                        catch(e){
                          print(e);
                        }
                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
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
