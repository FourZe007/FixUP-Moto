// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:fixupmoto/global/global.dart';
import 'package:fixupmoto/widget/textfield.dart/customxuserinput.dart';

class InputanPassword extends StatefulWidget {
  const InputanPassword(this.label, this.handle,
      {this.isLogin = true, super.key});

  final String label;
  final Function handle;
  final bool isLogin;

  @override
  State<InputanPassword> createState() => _InputanPasswordState();
}

class _InputanPasswordState extends State<InputanPassword>
    with AutomaticKeepAliveClientMixin<InputanPassword> {
  bool hidePassword = true;
  TextEditingController inputcontroller = TextEditingController();

  void showHidePasword() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  @override
  void dispose() {
    super.dispose();
    inputcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin:
          const EdgeInsets.only(left: 15.0, right: 15.0, top: 0, bottom: 10.0),
      alignment: Alignment.centerLeft,
      height: 40,
      child: TextField(
          inputFormatters: [UpperCaseText()],
          controller: inputcontroller,
          obscureText: hidePassword,
          style: GlobalFont.mediumbigfontM,
          decoration: InputDecoration(
              hintText: 'Masukkan ${widget.label}',
              hintStyle: GlobalFont.mediumbigfontM,
              contentPadding:
                  widget.isLogin == true ? null : const EdgeInsets.all(10),
              suffixIcon: IconButton(
                icon: Icon(
                    hidePassword ? Icons.visibility_off : Icons.visibility,
                    size: 20,
                    color: Colors.black),
                color: Theme.of(context).primaryColorDark,
                onPressed: () => showHidePasword(),
              )),
          onChanged: (newValues) => widget.handle(newValues)),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
