import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:blackbox/providers/auth_service.dart';
import 'package:blackbox/screens/setup.dart';
import 'package:blackbox/utils/constants.dart';
import 'package:blackbox/widgets/menu.dart';

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:google_sign_in/google_sign_in.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      drawer: Menu(
        scaffoldKey: scaffoldKey,
      ),
      backgroundColor: AppColors().backgroundPurple,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 30.0, 25.0, 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => scaffoldKey.currentState!.openDrawer(),
                    child: const Icon(
                      Icons.menu_rounded,
                      color: Colors.black87,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Flexible(
                child: Text(
                  "Hi ${FirebaseAuth.instance.currentUser!.displayName!.split(' ')[0]}",
                  style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              const Flexible(
                child: Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Text(
                    "Here's your balance",
                    style: TextStyle(
                      color: Colors.black26,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              FutureBuilder<DataSnapshot>(
                future: FirebaseDatabase.instance
                    .ref()
                    .child(FirebaseAuth.instance.currentUser!.uid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final _snapshot = snapshot.data;
                    if (_snapshot!.exists) {
                      Map<String, dynamic> data =
                          jsonDecode(jsonEncode(_snapshot.value))
                              as Map<String, dynamic>;
                      return Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 15.0, bottom: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Bank",
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                top: 5.0, right: 3.0),
                                            child: Text(
                                              "INR",
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              // Note: Styles for TextSpans must be explicitly defined.
                                              // Child text spans will inherit styles from parent
                                              style: const TextStyle(
                                                fontSize: 30.0,
                                                color: Colors.black,
                                              ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: data["bank"]
                                                        .truncate()
                                                        .toString()),
                                                TextSpan(
                                                  text:
                                                      ".${((data["bank"] - data["bank"].truncate()) * 100).truncate().toString().padLeft(2, '0')}",
                                                  style: const TextStyle(
                                                      fontSize: 20),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                    color: Colors.black54,
                                    width: 0.5,
                                    height: 35.0,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Cash",
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                top: 5.0, right: 3.0),
                                            child: Text(
                                              "INR",
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              // Note: Styles for TextSpans must be explicitly defined.
                                              // Child text spans will inherit styles from parent
                                              style: const TextStyle(
                                                fontSize: 30.0,
                                                color: Colors.black,
                                              ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: data["cash"]
                                                        .truncate()
                                                        .toString()),
                                                TextSpan(
                                                  text:
                                                      ".${((data["cash"] - data["cash"].truncate()) * 100).truncate().toString().padLeft(2, '0')}",
                                                  style: const TextStyle(
                                                      fontSize: 20),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Setup()),
                        );
                      });
                      return const Text('No data available.');
                    }
                  } else {
                    // Show a loading widget
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
