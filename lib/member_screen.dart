import 'package:flutter/material.dart';

class MemberScreen extends StatelessWidget {

  MemberScreen({this.email});


  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome Member"),),
      body: Column(
        children: <Widget>[
          Text('Hello $email', style: TextStyle(fontSize: 20.0),),

          RaisedButton(
            child: Text("LogOUt"),
            onPressed: (){
              Navigator.pushReplacementNamed(context,'/MyHomePage');
            },
          ),
        ],
      ),
    );
  }
}
