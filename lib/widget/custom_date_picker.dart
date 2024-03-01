import 'package:flutter/material.dart';
import 'package:fixupmoto/widget/format.dart';

class CustomDatetimePicker extends StatefulWidget {
  const CustomDatetimePicker(this.tgl, this.handle, {Key? key})
      : super(key: key);
  final String tgl;
  final Function handle;

  @override
  State<CustomDatetimePicker> createState() => _DatePicker1State();
}

class _DatePicker1State extends State<CustomDatetimePicker> {
  String tgl = '';

  @override
  void initState() {
    tgl = widget.tgl == ''
        ? DateTime.now().toString().substring(0, 10)
        : widget.tgl;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: tgl == '' ? DateTime.now() : DateTime.parse(tgl),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != DateTime.parse(tgl)) {
      setState(() {
        tgl = picked.toString().substring(0, 10);
      });
      widget.handle(tgl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectDate(context),
      child: Container(
        height: 50.0,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          // border: Border.all(color: Colors.black, width: 2),
        ),
        child: (MediaQuery.of(context).size.width <= 800)
            ? Row(
                children: [
                  const Icon(
                    Icons.date_range_rounded,
                    size: 18,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    Format.tanggalFormat(tgl),
                    textAlign: TextAlign.left,
                  ),
                ],
              )
            : Row(
                children: [
                  const Icon(
                    Icons.date_range_rounded,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    Format.tanggalFormat(tgl),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
      ),
    );
  }
}
