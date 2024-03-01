// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fixupmoto/global/global.dart';

class CustomUserInputSuffix extends StatelessWidget {
  CustomUserInputSuffix(this.handle, this.value, this.isUpper, this.hint,
      {required this.icon, super.key});

  final Function handle;
  final String value;
  bool isUpper;
  String hint;
  IconData icon;
  TextEditingController inputController = TextEditingController();

  bool isLoading = false;
  bool isVerified = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        top: 10.0,
        bottom: 10.0,
      ),
      alignment: Alignment.centerLeft,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: TextFormField(
        controller: TextEditingController(text: value),
        style: GlobalFont.mediumbigfontM,
        decoration: InputDecoration(
          hintStyle: GlobalFont.mediumbigfontM,
          hintText: 'Masukkan $hint Anda',
          border: InputBorder.none,
          prefixIcon: Container(
            margin: const EdgeInsets.only(right: 7),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              color: Colors.black,
            ),
            width: 50,
            child: Icon(icon, size: 20, color: Colors.white),
          ),
          suffixIcon: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              backgroundColor: Colors.black,
            ),
            onPressed: null,
            child:
                const Icon(Icons.check_circle, size: 20, color: Colors.white),
          ),
        ),
        onChanged: (newValues) {
          print('OTP code: $newValues');
          handle(newValues);
        },
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

class LowerCaseText extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toLowerCase(),
      selection: newValue.selection,
    );
  }
}
