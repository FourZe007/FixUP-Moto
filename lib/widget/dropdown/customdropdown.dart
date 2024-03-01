import 'package:flutter/material.dart';
import 'package:fixupmoto/global/global.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown(
      {required this.listData,
      required this.inputan,
      required this.hint,
      required this.handle,
      this.disable = false,
      super.key});
  final List<dynamic> listData;
  final String inputan;
  final String hint;
  final Function handle;
  final bool disable;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String teksDisable = '';
  late String value;

  @override
  void initState() {
    value = widget.inputan;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
            Icons.directions_car_rounded,
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
                hint: Text(
                  'Masukkan ${widget.hint}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Metropolis',
                  ),
                ),
                value: value == '' ? null : value,
                icon: const Icon(
                  Icons.keyboard_double_arrow_down_sharp,
                  size: 25,
                ),
                items: widget.disable == true
                    ? null
                    : widget.listData.map((items) {
                        return DropdownMenuItem(
                          value: items['value'].toString(),
                          child: Text(
                            items['teks'].toString(),
                            style: GlobalFont.mediumfontR,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                onChanged: (newValues) {
                  if (value != newValues) {
                    setState(() => value = newValues.toString() ?? '');
                    widget.handle(newValues);
                  }
                },
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
