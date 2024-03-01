import 'dart:async';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TimerPerSec extends StatefulWidget {
  TimerPerSec(this.checkUserAccess, {super.key});

  Function checkUserAccess;

  @override
  State<TimerPerSec> createState() => _TimerPerSecState();
}

class _TimerPerSecState extends State<TimerPerSec> {
  Timer? _timer = null;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        widget.checkUserAccess();
      });
      // widget.checkUserAccess();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // Use the _currentTime variable here
    return Container();
  }
}
