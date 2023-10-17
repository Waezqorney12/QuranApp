import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ContainerSholat extends StatelessWidget {
  final Widget child;
  final double? widht;
  final double? height;
  final Decoration? decoration;
  const ContainerSholat({super.key, required this.child, this.widht, this.height, this.decoration});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widht,
      height: height,
      decoration: decoration,
      child: child,
    );
  }
}