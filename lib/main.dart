import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:user_auth/admin_screen.dart';
import 'package:user_auth/member_screen.dart';



void main() => runApp(MyApp());

String email='';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User auth',
      home: MyHomePage(),
      routes: <String,WidgetBuilder>{
        '/AdminScreen': (BuildContext context)=> AdminScreen(email: email,),
        '/MemberScreen': (BuildContext context)=> MemberScreen(email: email,),
        '/MyHomePage': (BuildContext context)=> MyHomePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String url = 'http://rasetapi.local/login/authenticate';

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  String msg='';

  Future<void> _login() async {

    Map<String, String> headers = {"Accept": "application/json"};
    Map<String, String> body = {'email': emailController.text, 'password': passwordController.text};

    final response = await http.post(url, headers: headers, body: body);

    print(response.body);
    var datauser = json.decode(response.body);

    if (datauser['level'] == 'admin') {
      //navigate to admin screen
      Navigator.pushReplacementNamed(context, '/AdminScreen');
    } else {
      //navigate to member screen
      Navigator.pushReplacementNamed(context, '/MemberScreen');

    }

  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"),),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text("Email",style: TextStyle(fontSize: 18.0),),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                    hintText: 'Email'
                ),
              ),
              Text("Password",style: TextStyle(fontSize: 18.0),),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'Password'
                ),
              ),

              RaisedButton(
                child: Text("Login"),
                onPressed: (){
                  _login();
                },
              ),

              Text(msg,style: TextStyle(fontSize: 20.0,color: Colors.red),)


            ],
          ),
        ),
      ),
    );
  }
}