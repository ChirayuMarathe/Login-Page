import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/auth.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage='';
  bool isLogin =true;
  final TextEditingController _controllerEmail=TextEditingController();
  final TextEditingController _controllerPassword=TextEditingController();

  Future<void> signInWithEmailAndPassword()async{
    try {
      await Auth().signInWithEmailAndPassword(

        email:_controllerEmail.text,
        password:_controllerPassword.text,
      );
    } on FirebaseAuthException catch (e){
      setState(() {
        errorMessage=e.message;
      });
    }
  }
  Future<void>createUserWithEmailAndPassword()async{
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _controllerEmail.text,
          password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage=e.message;
      });
    }
  }
  Widget title(){
    return const Text(('Firebase Auth'));
  }
  Widget entryField(
      String title,
      TextEditingController controller,)
  {
    return TextField();
  }
  Widget _errorMessage(){
    return Text(errorMessage==''?'':'Hummm ? $errorMessage');
  }
  Widget _submitButton(){
    return ElevatedButton(onPressed:
        isLogin ? signInWithEmailAndPassword:createUserWithEmailAndPassword
        , child:Text(isLogin? 'Login':'Register'),
    );
  }
Widget _LoginOrRegisterButton(){
    return TextButton(
      onPressed: (){
        setState(() {
          isLogin=!isLogin;
        });
      },
      child:Text(isLogin?'Register instead':'Login instead'),
    );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:title()
        ),
    body:Container(
    height:double.infinity,
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      entryField('email', _controllerEmail),
      entryField('password', _controllerPassword),
      _errorMessage(),
      _submitButton(),
      _LoginOrRegisterButton(),


    ],
    ),
    )
    );
  }
}
