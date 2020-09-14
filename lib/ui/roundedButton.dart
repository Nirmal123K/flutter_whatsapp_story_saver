import 'package:flutter/material.dart';
class RoudedButton extends StatelessWidget {

final Function onPressed;
  final double height;
  final Color backgroundColor;
  final Widget child;
  final double elevation;
  final double width;
  final Color splashColor;

  const RoudedButton({
    @required this.onPressed,
      this.height,
      this.elevation,
      this.backgroundColor,
      this.width,
      this.splashColor,
      @required this.child
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      elevation: elevation ?? 10,
      shape: roundedButtonShape,
      child: MaterialButton(
        splashColor: splashColor,
        hoverElevation: 5.0,
        height: height,
        minWidth: width,
        shape: roundedButtonShape,
        onPressed: onPressed,
        child: child,
      ),
    );

  }
}
ShapeBorder roundedButtonShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(50)),
);