import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutterapp/config/palette.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'google_signin.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  bool isSignupScreen = true;
  bool isRememberMe = false;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            //main container for login page and signup page
            right: 0,
            left: 0,
            child: Container(
              height: 220,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Palette.loginPageColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                color: Palette.loginPageColor,
              ),
              child: Container(
                  padding: EdgeInsets.only(top: 90, left: 20),
                  color: Palette.loginPageColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(
                              text: "Social",
                              style: TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                              ),
                              children: [
                            TextSpan(
                                text: "X",
                                style: TextStyle(
                                  fontSize: 60,
                                  color: Colors.white,
                                ))
                          ]))
                    ],
                  )),
            ),
          ),
          Positioned(
            top: 200,
            child: Container(
              height: 380,
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width - 40,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 5,
                    ),
                  ]),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isSignupScreen = false;
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              "LOGIN",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: !isSignupScreen
                                    ? Palette.loginPageColor
                                    : Colors.grey,
                              ),
                            ),
                            if (!isSignupScreen)
                              Container(
                                margin: EdgeInsets.only(top: 3),
                                height: 2,
                                width: 55,
                                color: Colors.red,
                              )
                          ],
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignupScreen = true;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "SIGNUP",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isSignupScreen
                                      ? Palette.loginPageColor
                                      : Colors.grey,
                                ),
                              ),
                              if (isSignupScreen)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Colors.red,
                                )
                            ],
                          )),
                    ],
                  ),
                  if (isSignupScreen) buildSignupSection(),
                  if (!isSignupScreen) buildSigninSection()
                ],
              ),
            ),
          ),
          //add submit button
          Positioned(
            right: 0,
            left: 0,
            top: 600,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 100, //height of button
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: RichText(
                          text: TextSpan(
                            text: isSignupScreen ? "REGISTER" : "LOGIN",
                            style: TextStyle(
                              fontSize: 20,
                              letterSpacing: 2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Palette
                                .loginPageColor, //background color of button
                            elevation: 3, //elevation of button
                            shape: RoundedRectangleBorder(
                                //to set border radius to button
                                borderRadius: BorderRadius.circular(30)),
                            padding: EdgeInsets.all(20)),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildSigninSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          buildTextField(Icons.mail_outline, "Johndeo@gmail.com", false, true),
          buildTextField(
              MaterialCommunityIcons.lock_outline, "**********", true, false),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: isRememberMe,
                    activeColor: Palette.homePageColor,
                    onChanged: (value) {
                      setState(() {
                        isRememberMe = !isRememberMe;
                      });
                    },
                  ),
                  Text("Remember me",
                      style: TextStyle(fontSize: 12, color: Colors.grey))
                ],
              ),
              TextButton(
                onPressed: () {},
                child: Text("Forgot Password?",
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
              )
            ],
          ),
          SizedBox(
            height: 50, // <-- SEE HERE
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              onPrimary: Colors.white,
              side: BorderSide(width: 1, color: Colors.grey),
              minimumSize: Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              AuthService().signInWithGoogle();
            },
            icon: FaIcon(
              FontAwesomeIcons.google,
              color: Color(0xfff8f7f5),
            ),
            label: Text("Sign up With Google"),
          )
        ],
      ),
    );
  }

  Container buildSignupSection() {
    return Container(
      margin: EdgeInsets.only(
        top: 20,
      ),
      child: Column(
        children: [
          buildTextField(
              MaterialCommunityIcons.account, "User name", false, false),
          buildTextField(
              MaterialCommunityIcons.email, "Johndoe@gmail.com", false, true),
          buildTextField(
              MaterialCommunityIcons.phone, "9876543210", false, false),
          buildTextField(MaterialCommunityIcons.lock, "Password", true, false),
          Container(
              width: 200,
              margin: EdgeInsets.only(top: 20),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "By pressing 'Submit button' you are agree to our",
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: "Terms & conditions",
                        style: TextStyle(color: Palette.loginPageColor),
                      )
                    ]),
              )),
        ],
      ),
    );
  }

  Widget buildTextField(
      IconData icon, String hintText, bool isPassword, bool isEmail) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: TextField(
          obscureText: isPassword,
          keyboardType:
              isEmail ? TextInputType.emailAddress : TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: Colors.redAccent,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(35.0)),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(35.0))),
            contentPadding: EdgeInsets.all(10),
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ));
  }
}
