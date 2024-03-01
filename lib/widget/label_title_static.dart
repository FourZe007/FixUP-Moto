// ignore_for_file: file_names

import 'package:flutter/material.dart';

class LabelTitleStatic extends StatelessWidget {
  const LabelTitleStatic(this.judul, this.modelfont,
      {this.gap = const EdgeInsets.all(20), super.key});

  final String judul;
  final EdgeInsetsGeometry gap;
  final TextStyle modelfont;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.025,
        left: MediaQuery.of(context).size.width * 0.02,
      ),
      padding: EdgeInsets.fromLTRB(
        MediaQuery.of(context).size.width * 0.02,
        10.0,
        10.0,
        10.0,
      ),
      child: Text(judul, style: modelfont),
    );
  }
}
