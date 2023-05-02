import 'package:flutter/material.dart';

import 'package:blackbox/providers/auth_service.dart';
import 'package:blackbox/utils/constants.dart';
import 'package:blackbox/widgets/menu.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:google_sign_in/google_sign_in.dart';

class Tasks{
  final String name;
  bool checked;
  Tasks({required this.name, required this.checked});
}
}

class ToDo extends StatefulWidget {
  const ToDo({Key? key}) : super(key: key);

  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
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
                  "TO DO",
                  style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              FutureBuilder<DataSnapshot>(
                future: FirebaseDatabase.instance.ref().child("test").get(),
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
      ),
    );
  }
}
