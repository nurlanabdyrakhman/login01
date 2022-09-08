import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_validator/form_validator.dart';
import 'package:login01/constants/app_con.dart';
import 'package:login01/screens/overview_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var isLoading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailValidator = ValidationBuilder().email().minLength(8).build();
  final _passwordValidator = ValidationBuilder().minLength(6).build();

  loginForm(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          isLoading = true;
        });
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        setState(() {
          isLoading = false;
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => OverviewScreen()));
        });
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            e.code,
            textAlign: TextAlign.center,
          ),
        ));
      }
    }
  }

  signUpForm(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          isLoading = true;
        });
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        setState(() {
          isLoading = false;
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => OverviewScreen()));
        });
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            e.code,
            textAlign: TextAlign.center,
          ),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'HI ',
                      style: AppCon.HeightButtonTxtStyle,
                    ),
                    SvgPicture.asset(
                      'image/login.svg',
                      width: 75,
                      height: 75,
                    )
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'email'.toUpperCase(),
                          labelStyle: AppCon.FielTxtStyle,
                          focusedBorder: AppCon.FielBorderColor,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: _emailValidator,
                      ),
                      if (!_isLogin)
                        SizedBox(
                          height: 20,
                        ),
                      if (!_isLogin)
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'username'.toUpperCase(),
                            labelStyle: AppCon.FielTxtStyle,
                            focusedBorder: AppCon.FielBorderColor,
                          ),
                        ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'PASSWORD'.toUpperCase(),
                          labelStyle: AppCon.FielTxtStyle,
                          focusedBorder: AppCon.FielBorderColor,
                        ),
                        obscureText: true,
                        validator: _passwordValidator,
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      if (isLoading) const CircularProgressIndicator(),
                      if (!isLoading)
                        MaterialButton(
                          height: 57,
                          color: AppCon.BtnBgColor,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(_isLogin ? 'Login' : 'SignUp'),
                          ),
                          onPressed: () {
                            if (_isLogin) {
                              loginForm(_emailController.text,
                                  _passwordController.text);
                            } else {
                              signUpForm(_emailController.text,
                                  _passwordController.text);
                            }
                          },
                        ),
                      SizedBox(
                        height: 15,
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(40),
                        animationDuration: Duration(seconds: 2),
                        color: Colors.white,
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;
                              });
                            },
                            child: Center(
                                child: Text(
                              _isLogin
                                  ? 'Creat new accound'
                                  : 'I already have an occaund',
                              style: AppCon.HeightButtonTxtStyle.copyWith(
                                  fontSize: 22),
                            ))),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
