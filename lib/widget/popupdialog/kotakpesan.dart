// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:fixupmoto/global/global.dart';
import 'package:fixupmoto/widget/button/button.dart';
import 'package:fixupmoto/widget/label_static.dart';

class KotakPesan extends StatelessWidget {
  const KotakPesan(this.header, this.detail, {super.key});

  final String header;
  final String detail;

  @override
  Widget build(BuildContext context) {
    void submit() {
      Navigator.pop(context);
    }

    return SizedBox(
      width: 300,
      height: MediaQuery.of(context).size.height / 4,
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
