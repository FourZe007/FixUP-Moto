// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fixupmoto/global/global.dart';

class UserInput extends StatelessWidget {
  const UserInput(this.handle, this.input,
      {this.jenisKeyboard = 'TEKS',
      this.mode = 1,
      this.hintLabel = '',
      super.key});

  final Function handle;
  final String jenisKeyboard;
  final int mode;
  final String input;
  final String hintLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: TextField(
        inputFormatters: [
          jenisKeyboard == 'TEKS'
              ? UpperCaseText()
              : FilteringTextInputFormatter.allow(RegExp(r'^-?[0-9.]*'))
        ],
        controller: TextEditingController(text: input),
        readOnly: mode == 0 ? true : false,
        style: GlobalFont.mediumbigfontR,
        decoration: InputDecoration(
          hintText: 'Masukkan $hintLabel anda',
          hintStyle: const TextStyle(
            color: Colors.black,
          ),
        ),
        onChanged: (value) => handle(value),
      ),
    );
  }
}

class UpperCaseText extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
