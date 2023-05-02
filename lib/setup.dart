import 'package:blackbox/constants.dart';
import 'package:blackbox/auth_service.dart';
import 'package:blackbox/main.dart';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Setup extends StatefulWidget {
  const Setup({Key? key}) : super(key: key);

  @override
  State<Setup> createState() => _SetupState();
}

class _SetupState extends State<Setup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final bankController = TextEditingController();
  final cashController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    bankController.dispose();
    cashController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 70.0),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 50.0),
                        child: Text(
                          "BLACKBOX",
                          style: const TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                    const Center(
                      child: Text(
                        "- init -",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 15.0,
                          bottom: 50.0,
                        ),
                        child: Text(
                          "Fill in the following details to get started.",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter bank balance',
                      ),
                      controller: bankController,
                      keyboardType: TextInputType.number,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter some text";
                        } else if (!RegExp(r"^(([0-9]*)|(([0-9]*)\.([0-9]*)))$")
                            .hasMatch(value)) {
                          return "Please enter a value greater than or equal to 0";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter cash available',
                      ),
                      controller: cashController,
                      keyboardType: TextInputType.number,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter some text";
                        } else if (!RegExp(r"^(([0-9]*)|(([0-9]*)\.([0-9]*)))$")
                            .hasMatch(value)) {
                          return "Please enter a value greater than or equal to 0";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            FirebaseDatabase.instance.ref().update({
                              FirebaseAuth.instance.currentUser!.uid: {
                                "bank": double.parse(bankController.text),
                                "cash": double.parse(cashController.text),
                                "transactions": [],
                                "todo": []
                              }
                            });
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => App()));
                          }
                        },
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              side: BorderSide(color: Colors.black, width: 0.2),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Text(
                            "START",
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
