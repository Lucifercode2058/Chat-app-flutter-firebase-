import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
User newlogin;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messagetextcontroller = TextEditingController();

  final _auth = FirebaseAuth.instance;

  String messages;
  @override
  void initState() {
    getuserdat();
    super.initState();
  }

  void getuserdat() async {
    try {
      final chater = await _auth.currentUser;
      if (chater != newlogin) {
        newlogin = chater;
        print(newlogin.email);
      }
    } catch (e) {
      Text('already registered');
    }
  }

  void getstreamsmessages() async {
    await for (var snapshots in _firestore.collection('Messages').snapshots()) {
      for (var msg in snapshots.docs) {
        print(msg.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // appBar: AppBar(
      //
      //   leading: null,
      //   actions: <Widget>[
      //     IconButton(
      //         icon: Icon(Icons.close),
      //         onPressed: () {
      //            _auth.signOut();
      //            Navigator.pop(context);
      //
      //         }),
      //   ],
      //   title: Text('⚡️Chat'),
      //   backgroundColor: Colors.transparent,
      // ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/walking-code.gif'),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder(

                stream: _firestore.collection('Messages').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.red,
                      ),
                    );
                  }

                  final messages = snapshot.data.docs.reversed;
                  List<messagebox> messagewidget = [];
                  for (var message in messages) {
                    final messagetext = message.data()['text'];
                    final messagesender = message.data()['Sender'];
                    final currentuser = newlogin.email;

                    final messagewidgets = messagebox(
                      text: messagetext,
                      sender: messagesender,
                      isme: currentuser == messagesender,
                    );

                    messagewidget.add(messagewidgets);
                  }
                  return Expanded(
                    child: ListView(
                      reverse: true,




                      padding: EdgeInsets.all(13),
                      children: messagewidget,
                    ),
                  );
                }),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                        color: Colors.red,fontWeight: FontWeight.w400
                      ),
                      controller: messagetextcontroller,
                      onChanged: (value) {
                        messages = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messagetextcontroller.clear();

                      _firestore.collection('Messages').add({
                        'text': messages,
                        'Sender': newlogin.email,
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
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

class messagebox extends StatelessWidget {
  final String text;
  final String sender;
  final bool isme;

  messagebox({this.text, this.sender, this.isme});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: isme?CrossAxisAlignment.end:CrossAxisAlignment.start, children: [
        Text(
          '$sender',
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w300),
        ),
        SizedBox(
          height: 5,
        ),
        Material(
            elevation: 15.0,
            borderRadius: isme?BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)):BorderRadius.only(
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),

            ),
            color: isme?Colors.blueAccent:Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '$text',
                style: TextStyle(color: isme?Colors.white:Colors.black),
              ),
            )),
      ]),
    );
    ;
  }
}
