import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';


class ContainerSholat extends StatelessWidget {
  final Widget child;
  final double height;
  final double widht;
  final BoxDecoration decoration;
  const ContainerSholat(  this.height, this.widht, this.decoration, this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: widht,
      decoration: decoration,
      child: child,
    );
  }
}