import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserTextField extends StatefulWidget {
  UserTextField(this.hint, this.handle, {this.isVerify = true, super.key});

  String hint;
  Function handle;
  bool isVerify;

  @override
  State<UserTextField> createState() => _UserTextFieldState();
}

class _UserTextFieldState extends State<UserTextField> {
  late TextEditingController userInput;

  @override
  void initState() {
    super.initState();
    userInput = TextEditingController();

    // print('isVerify: ${widget.isVerify}');
  }

  @override
  void dispose() {
    userInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Masukkan ${widget.hint} anda',
          hintStyle: const TextStyle(
            color: Colors.black,
          ),
        ),
        controller: userInput,
        onChanged: (value) => widget.handle(value),
      ),
    );
  }
}
