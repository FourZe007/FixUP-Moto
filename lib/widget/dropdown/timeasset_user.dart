// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:fixupmoto/global/global.dart';

class UserTimeAsset extends StatefulWidget {
  UserTimeAsset(this.setData, this.inputan, {this.mode = 1, super.key});

  final Function setData;
  String inputan = 'Select your schedule';
  final int mode;

  @override
  State<UserTimeAsset> createState() => UserTimeAssetState();
}

class UserTimeAssetState extends State<UserTimeAsset> {
  String selectedValue = 'Select your schedule';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 50.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      child: Row(
        children: [
          const Icon(
            Icons.timer_rounded,
            size: 18,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.03,
          ),
          DropdownButtonHideUnderline(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: DropdownButton(
                borderRadius: BorderRadius.circular(20),
                icon: const Icon(
                  Icons.keyboard_double_arrow_down_sharp,
                  size: 25,
                ),
                items: [
                  DropdownMenuItem(
                    value: '09:00',
                    child: Text(
                      '09:00 - 10:00',
                      style: GlobalFont.mediumfontR,
                    ),
                  ),
                  DropdownMenuItem(
                    value: '10:00',
                    child: Text(
                      '10:00 - 11:00',
                      style: GlobalFont.mediumfontR,
                    ),
                  ),
                  DropdownMenuItem(
                    value: '14:00',
                    child: Text(
                      '14:00 - 15:00',
                      style: GlobalFont.mediumfontR,
                    ),
                  ),
                ],
                onChanged: (newvalues) {
                  if (widget.inputan != newvalues) {
                    widget.setData(newvalues);
                    setState(() {
                      widget.inputan = newvalues!;
                    });
                    print(widget.inputan);
                  }
                },
                value: widget.inputan,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
