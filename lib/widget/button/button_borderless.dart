// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:fixupmoto/global/global.dart';

class TombolBorderless extends StatefulWidget {
  const TombolBorderless(this.namaButton, this.handle,
      {this.lebar = 75, this.tinggi = 40, super.key});

  final String namaButton;
  final Function handle;
  final double lebar;
  final double tinggi;

  @override
  State<TombolBorderless> createState() => _TombolBorderlessState();
}

class _TombolBorderlessState extends State<TombolBorderless> {
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
            color: aktif == false ? Colors.black : Colors.grey,
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              widget.namaButton,
              style: GlobalFont.mediumfontC,
            ),
          ),
        ),
      ),
    );
  }
}
