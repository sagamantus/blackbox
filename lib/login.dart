import 'package:blackbox/constants.dart';
import 'package:blackbox/auth_service.dart';
import 'dart:math';
import 'package:flutter/material.dart';

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
                      AuthService().signInWithGoogle();
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

class Cube extends StatelessWidget {
  const Cube({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform(
          transform: Matrix4.identity()
            ..translate(0.0, 0.0, -50.0)
            ..rotateY(-pi / 2),
          child: Container(
            color: Colors.black87.withOpacity(0.5),
            height: 100,
            width: 100,
          ),
        ),
        Transform(
          transform: Matrix4.identity()
            ..translate(100.0, 0.0, -50.0)
            ..rotateY(-pi / 2),
          child: Container(
            color: Colors.red.withOpacity(0.5),
            height: 100,
            width: 100,
          ),
        ),
        Transform(
          transform: Matrix4.identity()
            ..translate(0.0, 100.0, -50.0)
            ..rotateX(pi / 2),
          child: Container(
            color: Colors.green.withOpacity(0.5),
            height: 100,
            width: 100,
          ),
        ),
        Transform(
          transform: Matrix4.identity()
            ..translate(0.0, 0.0, -50.0)
            ..rotateX(pi / 2),
          child: Container(
            color: Colors.teal.withOpacity(0.5),
            height: 100,
            width: 100,
          ),
        ),
        Transform(
          transform: Matrix4.identity()..translate(0.0, 0.0, -50.0),
          child: Container(
            color: Colors.blue.withOpacity(0.5),
            height: 100,
            width: 100,
          ),
        ),
        Transform(
          transform: Matrix4.identity()..translate(0.0, 0.0, 50.0),
          child: Container(
            color: Colors.amber.withOpacity(0.5),
            height: 100,
            width: 100,
          ),
        ),
      ],
    );
  }
}
