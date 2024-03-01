import 'package:fixupmoto/global/global.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FilterButton extends StatelessWidget {
  FilterButton(this.text, this.isPressed, this.width, {super.key});

  String text;
  bool isPressed;
  double width;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: width,
      height: MediaQuery.of(context).size.height * 0.045,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isPressed == true ? Colors.grey : Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey, // Adjust shadow color as needed
            offset: Offset(2.0, 4.0), // Adjust shadow offset
            blurRadius: 5.0, // Adjust shadow blur radius
            spreadRadius: 1.0, // Adjust shadow spread radius
          ),
        ],
      ),
      child: Text(
        text,
        style: GlobalFont.middlebigfontM,
      ),
    );
  }
}
