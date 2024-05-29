import 'package:bank/Screen/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bank/Utils/colors.dart';
import 'package:bank/main.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _username = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              backgroundColor2,
              backgroundColor2,
              backgroundColor4,
            ],
          ),
        ),
        child: SafeArea(
          child: ListView(
            children: [
              SizedBox(height: size.height * 0.03),
              Text(
                "Welcome!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 37,
                  color: textColor1,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "Create an account to get started",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 27,
                  color: textColor2,
                  height: 1.2,
                ),
              ),
              SizedBox(height: size.height * 0.04),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      myTextField("Enter username", Colors.white, (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        _username = value;
                        return null;
                      }),
                      myTextField("Enter email", Colors.white, (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        _email = value;
                        return null;
                      }),
                      myTextField("Password", Colors.black26, (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        _password = value;
                        return null;
                      }, obscureText: true),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignIn(),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: textColor2,
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          child: Text(
                            "Already have an account?",
                            style: TextStyle(color: Colors.lightBlue),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.04),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              await _auth.createUserWithEmailAndPassword(
                                  email: _email, password: _password);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => App()));
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'email-already-in-use') {
                                showErrorDialog(context,
                                    'The account already exists for that email.');
                              } else {
                                showErrorDialog(context, e.message!);
                              }
                            }
                          }
                        },
                        child: const Center(
                          child: Text(
                            "Register",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                      // The rest of your code for social login
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget myTextField(String hint, Color color, FormFieldValidator<String>? validator,
      {bool obscureText = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 10,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 22,
          ),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15),
          ),
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.black45,
            fontSize: 19,
          ),
          suffixIcon: Icon(
            Icons.visibility_off_outlined,
            color: color,
          ),
        ),
        obscureText: obscureText,
        validator: validator,
      ),
    );
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
