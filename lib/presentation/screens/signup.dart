
import 'dart:developer';

import 'package:expanse_management/presentation/screens/category_screen.dart';
import 'package:expanse_management/presentation/screens/home.dart';
import 'package:expanse_management/presentation/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}



class _SignUpState extends State<SignUp> {
  final TextEditingController nameController = TextEditingController();
 final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 41, 55, 145),
      appBar: AppBar(
        title: Text("Sign Up"),
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
              SizedBox(height: 50,),
               Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                      filled:true,
                     // border: OutlineInputBorder(),
                      labelText: 'Name',
                      hintText: 'Enter Your Name'),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                      filled:true,
                     // border: OutlineInputBorder(),
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
                      //border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter Password'),
                ),
              ),
              // TextButton(
              //   onPressed: (){
              //     //TODO FORGOT PASSWORD SCREEN GOES HERE
              //   },
              //   child: Text(
              //    // 'Forgot Password',
              //     style: TextStyle(color: Colors.white, fontSize: 15),
              //   ),
              // ),
              const SizedBox(height: 80),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 3, 13, 21), borderRadius: BorderRadius.circular(20)),
                child: ElevatedButton(
                  onPressed: () async {
                   _signup();
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

  Future<void> _signup() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
        
      );

       // ignore: use_build_context_synchronously
        Navigator.push(
        context,
        MaterialPageRoute(
          // ignore: prefer_const_constructors
          builder: (context) => LoginDemo(),
        ),
      );

      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      sharedPref.setString('userName', nameController.text);
      // Handle successful signup
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
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