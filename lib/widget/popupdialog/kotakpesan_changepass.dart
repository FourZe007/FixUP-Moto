// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:fixupmoto/global/global.dart';
import 'package:fixupmoto/widget/button/button.dart';
import 'package:fixupmoto/widget/label_static.dart';

// ignore: must_be_immutable
class KotakPesanChangePass extends StatefulWidget {
  KotakPesanChangePass(this.header, this.hint, this.oldPass, this.newPass,
      this.confirmPass, this.submit,
      {this.buttonWidth1 = 50,
      this.buttonHeight1 = 30,
      this.buttonWidth2 = 70,
      this.buttonHeight2 = 30,
      this.sizedBoxWidth = 300,
      this.sizedBoxHeight = 300,
      this.autoFocus = false,
      this.icon = Icons.question_mark_rounded,
      super.key});

  final String header;
  final String hint;
  Widget oldPass;
  Widget newPass;
  Widget confirmPass;
  Function submit;
  double buttonWidth1;
  double buttonHeight1;
  double buttonWidth2;
  double buttonHeight2;
  double sizedBoxWidth;
  double sizedBoxHeight;
  bool autoFocus;
  IconData icon;

  @override
  State<KotakPesanChangePass> createState() => _KotakPesanChangePassState();
}

class _KotakPesanChangePassState extends State<KotakPesanChangePass>
    with AutomaticKeepAliveClientMixin<KotakPesanChangePass> {
  TextEditingController inputController = TextEditingController();
  bool hidePassword = true;

  void showHidePasword() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    void cancel() {
      Navigator.pop(context);
    }

    return SizedBox(
      width: widget.sizedBoxWidth,
      height: (widget.sizedBoxHeight == 300)
          ? MediaQuery.of(context).size.height / 5
          : widget.sizedBoxHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [LabelStatic(widget.header, GlobalFont.mediumfontM)],
          ),
          const Divider(
            color: Colors.black,
            thickness: 2,
            indent: 10,
            endIndent: 10,
          ),
          Expanded(child: widget.oldPass),
          Expanded(child: widget.newPass),
          Expanded(child: widget.confirmPass),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Tombol(
                  'OK',
                  widget.submit,
                  lebar: widget.buttonWidth1,
                  tinggi: widget.buttonHeight1,
                ),
                const SizedBox(width: 15.0),
                Tombol(
                  'CANCEL',
                  cancel,
                  lebar: widget.buttonWidth2,
                  tinggi: widget.buttonHeight2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
