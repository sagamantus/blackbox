import 'package:flutter/material.dart';

import 'package:blackbox/utils/constants.dart';
import 'package:blackbox/providers/auth_service.dart';
import 'package:blackbox/screens/dashboard.dart';
import 'package:blackbox/screens/todo.dart';

import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:google_sign_in/google_sign_in.dart';

class Menu extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const Menu({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Stack(
        children: [
          Stack(
            children: [
              Transform.rotate(
                angle: pi / 6,
                child: Container(
                  color: Colors.amber.withOpacity(0.5),
                  height: 200,
                  width: 200,
                ),
              ),
              Transform(
                transform: Matrix4.identity()
                  ..translate(100.0, 120.0, -25.0)
                  ..rotateZ(pi / 12),
                child: Container(
                  color: Colors.teal.withOpacity(0.5),
                  height: 150,
                  width: 150,
                ),
              ),
              Transform(
                transform: Matrix4.identity()
                  ..translate(270.0, 350.0, 25.0)
                  ..rotateZ(2 * pi / 3),
                child: Container(
                  color: Colors.green.withOpacity(0.5),
                  height: 50,
                  width: 50,
                ),
              ),
              Transform(
                transform: Matrix4.identity()
                  ..translate(100.0, 450.0, 25.0)
                  ..rotateZ(pi / 18),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  height: 70,
                  width: 70,
                ),
              ),
              Transform(
                transform: Matrix4.identity()
                  ..translate(30.0, 250.0, 25.0)
                  ..rotateZ(pi / 4),
                child: Container(
                  color: Colors.red.withOpacity(0.5),
                  height: 150,
                  width: 150,
                ),
              ),
              Transform(
                transform: Matrix4.identity()
                  ..translate(300.0, 300.0, -25.0)
                  ..rotateZ(pi),
                child: Container(
                  color: Colors.blue.withOpacity(0.5),
                  height: 70,
                  width: 70,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 50.0),
            child: Align(
              alignment: AlignmentDirectional.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () =>
                            widget.scaffoldKey.currentState!.closeDrawer(),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black87,
                              width: 2,
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              Icons.arrow_back_ios_rounded,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: CircleAvatar(
                          radius: 38,
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              FirebaseAuth.instance.currentUser!.photoURL!,
                              height: 70.0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 5,
                      ),
                      Center(
                        child: Text(
                          FirebaseAuth.instance.currentUser!.displayName!,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          FirebaseAuth.instance.currentUser!.email!,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          child: const Text(
                            'DASHBOARD',
                            style:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onPressed: () {
                            widget.scaffoldKey.currentState!.closeDrawer();
                            Navigator.of(context).pushReplacement(
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => Dashboard(),
                                transitionDuration: Duration(milliseconds: 150),
                                transitionsBuilder: (_, a, __, c) =>
                                    FadeTransition(opacity: a, child: c),
                              ),
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          child: const Text(
                            'TO DO LIST',
                            style:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onPressed: () {
                            widget.scaffoldKey.currentState!.closeDrawer();
                            Navigator.of(context).pushReplacement(
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => ToDo(),
                                transitionDuration: Duration(milliseconds: 150),
                                transitionsBuilder: (_, a, __, c) =>
                                    FadeTransition(opacity: a, child: c),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      child: const Text(
                        'LOG OUT',
                        style: TextStyle(color: Colors.black54, fontSize: 15),
                      ),
                      onPressed: () {
                        AuthService().signOut();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
