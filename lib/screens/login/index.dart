import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homi/helper/helper.dart';
import 'package:homi/screens/signup/index.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeAppBarColors(),
      appBar: AppBar(
        backgroundColor: themeAppBarColors(),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,color: themeAppColors(),)),
        title: sText("Sign In",weight: FontWeight.bold,size: 20),
        centerTitle: false,
      ),

      body: Container(
        padding: EdgeInsets.only(left: 10,right: 10,bottom: 20,top: 20),
        child: Column(
          children: [

            Expanded(
              child: ListView(
                children: [
                  Container(
                    child: displayImage("imagePath",),
                  ),
                  SizedBox(height: 30,),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: leftPadding(10),
                          child: sText("Email",weight: FontWeight.bold),
                        ),
                        Container(
                          margin: leftPadding(10),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailController,
                                  autofocus: false,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please check that you\'ve entered your email correctly';
                                    }
                                    return null;
                                  },
                                  decoration: textDecor(

                                    label: 'Email',
                                    hint: "Enter email",
                                    hintColor: dPurple,
                                    padding: noPadding(),
                                    icon: Container(
                                        margin: rightPadding(20),
                                        child: Icon(Icons.email, color: dPurple),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30,),
                        Container(
                          margin: leftPadding(10),
                          child: sText("Password",weight: FontWeight.bold),
                        ),
                        Container(
                          margin: leftPadding(10),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                  controller: passwordController,
                                  autofocus: false,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please check that you\'ve entered your password correctly';
                                    }
                                    return null;
                                  },
                                  decoration: textDecor(
                                    label: 'Password',
                                    hint: "Enter Password",
                                    hintColor: dPurple,
                                    padding: noPadding(),
                                    icon: Container(
                                      margin: rightPadding(20),
                                      child: Icon(Icons.lock_outline, color: dPurple),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              child: sText2("Forgot Password?",color: dPurple,weight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 40,right: 40,top: 10,bottom: 10),
                              child: sText2("Sign In",color: Colors.white,weight: FontWeight.bold),
                              decoration: BoxDecoration(
                                color: dPurple,
                                borderRadius: BorderRadius.circular(30)
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: sText("..........Or..........",weight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 300,
                              padding: EdgeInsets.only(left: 20,right: 20,top: 15,bottom: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(FontAwesomeIcons.apple,color: Colors.white,),
                                  SizedBox(width: 10,),
                                  sText2("Sign in with Apple",color: Colors.white,weight: FontWeight.bold),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(30)
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Container(
                              width: 300,
                              padding: EdgeInsets.only(left: 20,right: 20,top: 15,bottom: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(FontAwesomeIcons.facebook,color: Colors.white,),
                                  SizedBox(width: 10,),
                                  sText2("Continue with Facebook",color: Colors.white,weight: FontWeight.bold),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(30)
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Container(
                              width: 300,
                              padding: EdgeInsets.only(left: 20,right: 20,top: 15,bottom: 15),                              child: Row(
                                children: [
                                  Icon(FontAwesomeIcons.google,color: Colors.white,),
                                  SizedBox(width: 10,),
                                  sText2("Continue with Google",color: Colors.white,weight: FontWeight.bold),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(30)
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        GestureDetector(
                          onTap: (){
                            goTo(context, SignupPage());
                          },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: sText("Dont't have an account? Please",weight: FontWeight.bold),
                                ),
                                SizedBox(width: 5,),
                                Container(
                                  child: sText2("Sign Up",color: dPurple,weight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),

    );
  }
}
