// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:fixupmoto/global/global.dart';

class Tombol extends StatefulWidget {
  const Tombol(this.namaButton, this.handle,
      {this.disable = false, this.lebar = 75, this.tinggi = 40, super.key});

  final bool disable;
  final String namaButton;
  final Function handle;
  final double lebar;
  final double tinggi;

  @override
  State<Tombol> createState() => _TombolState();
}

class _TombolState extends State<Tombol> {
  // bool disable = false;
  int mode = 1;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.handle != null) {
          widget.handle();
        }
      },
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        width: widget.lebar,
        height: widget.tinggi,
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.disable == false ? Colors.black : Colors.grey,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(
                3.0,
                3.0,
              ),
              blurRadius: 10.0,
              spreadRadius: 1.0,
            ),
          ],
          borderRadius: BorderRadius.circular(20),
          color: widget.disable == false ? Colors.black : Colors.grey,
          // color: Colors.black,
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            widget.namaButton,
            style: widget.disable == false
                ? GlobalFont.bigfontCWhite
                : GlobalFont.bigfontC,
          ),
        ),
      ),
    );
  }
}
