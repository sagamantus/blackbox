import 'package:blackbox/constants.dart';
import 'package:blackbox/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';

dashboard(scaffoldKey) {
  FirebaseDatabase database = FirebaseDatabase.instance;
  final ref = FirebaseDatabase.instance.ref();
  return SafeArea(
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
                  color: blueText,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Flexible(
            child: Text(
              "Hello " + FirebaseAuth.instance.currentUser!.uid + "!",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          FutureBuilder<DataSnapshot>(
            future: ref.child("test").get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final _snapshot = snapshot.data;
                if (_snapshot!.exists) {
                  return Text(_snapshot.value.toString());
                } else {
                  return Text('No data available.');
                }
              } else {
                // Show a loading widget
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    ),
  );
}
