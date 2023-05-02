import 'package:flutter/material.dart';

import 'package:blackbox/utils/constants.dart';
import 'package:blackbox/providers/auth_service.dart';
import 'package:blackbox/widgets/cube.dart';

import 'dart:math';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Offset _offset = Offset(124.7, 20.7);

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() => _offset += details.delta);
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 50,
              ),
              Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateX(_offset.dy * pi / 180)
                  ..rotateY(_offset.dx * pi / 180),
                alignment: Alignment.center,
                child: Container(
                  height: 300,
                  child: Center(
                    child: Cube(),
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Text(
                    "BLACKBOX",
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Text(
                    "Hold and drag anywhere to rotate",
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              Container(
                height: 200,
              ),
              Container(
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      AuthService().signInWithGoogle(context);
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          side: BorderSide(color: Colors.black, width: 0.2),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          image: AssetImage("assets/google_logo.png"),
                          height: 15.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Sign in with Google  ",
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
