import 'package:flutter/material.dart';

import 'package:blackbox/utils/constants.dart';
import 'package:blackbox/providers/auth_service.dart';
import 'package:blackbox/screens/dashboard.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:google_sign_in/google_sign_in.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Dashboard();
  }
}
