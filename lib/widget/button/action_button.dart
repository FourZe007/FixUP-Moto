import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ActionButton extends StatefulWidget {
  ActionButton(this.name, this.handle, {super.key});

  String name;
  Function handle;

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        widget.handle();
      },
      child: Container(
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.width * 0.035,
          bottom: MediaQuery.of(context).size.width * 0.035,
        ),
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.04,
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                alignment: Alignment.centerRight,
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
