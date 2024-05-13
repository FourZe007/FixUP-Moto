// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:fixupmoto/global/global.dart';
import 'package:fixupmoto/widget/button/button.dart';
import 'package:fixupmoto/widget/label_static.dart';

class KotakPesan extends StatelessWidget {
  const KotakPesan(this.header, this.detail, {this.tinggi = 0.0, super.key});

  final String header;
  final String detail;
  final double tinggi;

  @override
  Widget build(BuildContext context) {
    void submit() {
      Navigator.pop(context);
    }

    return SizedBox(
      width: 300,
      height:
          (tinggi == 0.0) ? MediaQuery.of(context).size.height * 0.25 : tinggi,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [LabelStatic(header, GlobalFont.mediumfontM)],
          ),
          const Divider(
              color: Colors.black, thickness: 2, indent: 10, endIndent: 10),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LabelStatic(detail, GlobalFont.mediumfontM),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Tombol('OK', submit, lebar: 50, tinggi: 30)],
            ),
          ),
        ],
      ),
    );
  }
}
