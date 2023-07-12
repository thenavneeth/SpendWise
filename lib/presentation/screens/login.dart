
import 'dart:developer';

import 'package:expanse_management/presentation/screens/category_screen.dart';
import 'package:expanse_management/presentation/screens/home.dart';
import 'package:expanse_management/presentation/widgets/bottom_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}



class _LoginDemoState extends State<LoginDemo> {
 final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 41, 55, 145),
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,

          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Container(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/images/logo2.png')),
              ),
              SizedBox(height: 80,),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                      filled:true,
                      //border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter Your Email'),
                ),
              ),
               SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled:true,
                     // border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter password'),
                ),
              ),
              // TextButton(
              //   onPressed: (){
              //     //TODO FORGOT PASSWORD SCREEN GOES HERE
              //   },
              //   child: Text(
              //     'Forgot Password',
              //     style: TextStyle(color: Colors.white, fontSize: 15),
              //   ),
              // ),
              const SizedBox(height: 60,),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                child: ElevatedButton(
                  onPressed: () async {
                   _login();
                    // Navigator.push(
                    //     context, MaterialPageRoute(builder: (_) => Home()));
                  },
                  child:const Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            //  const  SizedBox(
            //     height: 130,
            //   ),
            //   const Text('New User? Create Account',style: TextStyle(color: Colors.white),)
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    try {
      log("Login function called");
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      log("done login");

        // ignore: use_build_context_synchronously
        Navigator.push(
        context,
        MaterialPageRoute(
          // ignore: prefer_const_constructors
          builder: (context) => Bottom(),
        ),
      );
      
      
      log("passed");
      // Handle successful login
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
      // Handle other exceptions
    } catch (e) {
      print(e.toString());
      // Handle other exceptions
    }
  }

// }

// class FirebaseAuth {
}