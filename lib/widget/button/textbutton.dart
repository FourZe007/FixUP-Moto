// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:fixupmoto/global/global.dart';

class CustomTextButton extends StatefulWidget {
  const CustomTextButton(this.namaButton, this.handle,
      {this.lebar = 75, this.tinggi = 40, super.key});

  final String namaButton;
  final Function handle;
  final double lebar;
  final double tinggi;

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  bool aktif = false;
  int mode = 1;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.handle != null) {
          widget.handle();
        }
      },
      child: MouseRegion(
        onEnter: (event) {
          setState(() {
            aktif = true;
          });
        },
        onExit: (event) {
          setState(() {
            aktif = false;
          });
        },
        child: Container(
          width: widget.lebar,
          height: widget.tinggi,
          decoration: BoxDecoration(
            // boxShadow: const [
            //   BoxShadow(
            //     color: Colors.grey,
            //     offset: Offset(
            //       3.0,
            //       3.0,
            //     ),
            //     blurRadius: 10.0,
            //     spreadRadius: 1.0,
            //   ),
            // ],
            // borderRadius: BorderRadius.circular(20),
            color: aktif == false ? Colors.transparent : Colors.grey,
          ),
          child: Text(
            widget.namaButton,
            style: GlobalFont.mediumfontM,
          ),
        ),
      ),
    );
  }
}
