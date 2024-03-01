// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:fixupmoto/global/global.dart';
import 'package:fixupmoto/widget/button/button.dart';
import 'package:fixupmoto/widget/label_static.dart';

// ignore: must_be_immutable
class KotakPesan2Button extends StatelessWidget {
  KotakPesan2Button(this.header, this.detail, this.submit,
      {this.buttonWidth1 = 50,
      this.buttonHeight1 = 30,
      this.buttonWidth2 = 70,
      this.buttonHeight2 = 30,
      this.sizedBoxWidth = 300,
      this.sizedBoxHeight = 300,
      super.key});

  final String header;
  final String detail;
  Function submit;
  double buttonWidth1;
  double buttonHeight1;
  double buttonWidth2;
  double buttonHeight2;
  double sizedBoxWidth;
  double sizedBoxHeight;

  @override
  Widget build(BuildContext context) {
    void cancel() {
      Navigator.pop(context);
    }

    return SizedBox(
      width: sizedBoxWidth,
      height: (sizedBoxHeight == 300)
          ? MediaQuery.of(context).size.height / 5
          : sizedBoxHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [LabelStatic(header, GlobalFont.mediumfontM)],
          ),
          const Divider(
            color: Colors.black,
            thickness: 2,
            indent: 10,
            endIndent: 10,
          ),
          Expanded(
            flex: 1,
            child: Wrap(
              alignment: WrapAlignment.spaceEvenly,
              children: [
                LabelStatic(detail, GlobalFont.mediumfontM),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Tombol(
                  'OK',
                  submit,
                  lebar: buttonWidth1,
                  tinggi: buttonHeight1,
                ),
                const SizedBox(width: 15.0),
                Tombol(
                  'CANCEL',
                  cancel,
                  lebar: buttonWidth2,
                  tinggi: buttonHeight2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
