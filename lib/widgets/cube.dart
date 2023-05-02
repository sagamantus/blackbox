import 'package:flutter/material.dart';

import 'package:blackbox/utils/constants.dart';

import 'dart:math';

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
