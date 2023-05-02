import 'package:blackbox/constants.dart';
import 'package:blackbox/auth_service.dart';
import 'package:blackbox/dashboard.dart';
import 'package:blackbox/setup.dart';
import 'package:blackbox/todo.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:math';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String page = "home";
  Color page_color = AppColors().backgroundPurple;
  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    // Drawer
    Drawer _drawer = Drawer(
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
                        onTap: () => scaffoldKey.currentState!.closeDrawer(),
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
                            page = "dashboard";
                            setState(() {});
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
                            page = "todo";
                            setState(() {});
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

    // Home Page
    SafeArea app_page = SafeArea(child: Container());
    if (page == "home") {
      page = "dashboard";
      var t = dashboard(context, scaffoldKey);
      app_page = t[0];
      page = t[1];
      setState(() {});
    } else if (page == "dashboard") {
      page = "dashboard";
      var t = dashboard(context, scaffoldKey);
      app_page = t[0];
      page = t[1];
      setState(() {});
    } else if (page == "todo") {
      app_page = todo(scaffoldKey);
    }
    return Scaffold(
        key: scaffoldKey,
        drawer: _drawer,
        backgroundColor: page_color,
        body: app_page);
  }
}
