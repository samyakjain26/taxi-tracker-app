import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'signup.dart';
import 'package:camera/camera.dart';
import 'camerapath.dart';
import 'videorecording.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController _email = TextEditingController();
  Color _iconcolor = Colors.grey;
  bool _logclick = false;
  TextEditingController _password = TextEditingController();
  bool seepass = false;
  final _emailtext = GlobalKey<FormState>();
  final _passwordtext = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
        ),
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.white,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Text(
                  "VideoTracker.",
                  style: TextStyle(
                    color: Color(0xff05386b),
                    fontSize: 50.0,
                  ),
                ),
                Spacer(),
                Form(
                  key: _emailtext,
                  child: Column(
                    children: [
                      Container(
                        // height: 44.6,
                        width: 375.93,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Email';
                            } else {
                              return null;
                            }
                          },
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              labelText: "Email",
                              hintText: "Email",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          // height: 44.6,
                          width: 375.93,
                          child: TextFormField(
                            controller: _password,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Password';
                              } else {
                                return null;
                              }
                            },
                            obscureText: seepass ? false : true,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (seepass) {
                                          seepass = false;
                                          _iconcolor = Colors.blue;
                                        } else {
                                          seepass = true;
                                          _iconcolor = Colors.grey;
                                        }
                                      });
                                    },
                                    icon: Icon(
                                      Icons.remove_red_eye,
                                      color: _iconcolor,
                                    )),
                                labelText: "Password",
                                hintText: "Password",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12, left: 20),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text("Forgot Password?",
                        style: TextStyle(
                            color: Color(0xff05386b), fontSize: 14.0)),
                  ),
                ),
                Spacer(),
                Container(
                  height: 44.6,
                  width: 375.93,
                  child: RaisedButton(
                    onPressed: () async {
                      setState(() {
                        if (_emailtext.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }
                      });

                      UserCredential userCredential = await FirebaseAuth
                          .instance
                          .signInWithEmailAndPassword(
                              email: _email.text, password: _password.text);

                      List<CameraDescription> cameras = [];
                      try {
                        // WidgetsFlutterBinding.ensureInitialized();
                      } on CameraException catch (e) {
                        cameras = await availableCameras();
                        logError(e.code, e.description);
                      }
                      main();
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => main()));
                      // CameraApp(cameras: cameras)));

                      // camerascreen();
                    },
                    color: Color(0xff5cdb95),
                    child: Text("Log in",
                        style: TextStyle(color: Colors.white, fontSize: 14.0)),
                  ),
                ),
                Spacer(),
                Row(children: <Widget>[
                  Expanded(
                    child: new Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                        child: Divider(
                          color: Colors.grey,
                          height: 50,
                        )),
                  ),
                  Text(
                    "OR",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Expanded(
                    child: new Container(
                        margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                        child: Divider(
                          color: Colors.grey,
                          height: 50,
                        )),
                  ),
                ]),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => signup()));
                      },
                      child: Text("Sign up",
                          style: TextStyle(
                              color: Color(0xff05386b), fontSize: 16)),
                    )
                  ],
                ),
                Spacer()
              ],
            )));
  }
}
