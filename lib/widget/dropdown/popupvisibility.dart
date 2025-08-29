import 'package:fixupmoto/global/api.dart';
import 'package:fixupmoto/global/global.dart';
import 'package:fixupmoto/global/model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class PopUpVisibility extends StatefulWidget {
  PopUpVisibility(this.list, {super.key});

  ModelGetVoucher list;

  @override
  State<PopUpVisibility> createState() => _PopUpVisibilityState();
}

class _PopUpVisibilityState extends State<PopUpVisibility> {
  bool _isPopupVisible = false;

  void _togglePopupVisibility() {
    setState(() {
      _isPopupVisible = !_isPopupVisible;
    });
  }

  void redeemVoucher() async {
    GlobalVar.listRedeemVoucher = await GlobalAPI.fetchRedeemVoucher(
      '1',
      widget.list.pointID,
    );
    print(GlobalVar.listRedeemVoucher[0].resultMessage);

    late SnackBar snackBar;
    if (GlobalVar.listRedeemVoucher[0].resultMessage ==
        'POIN ANDA TIDAK MENCUKUPI UNTUK REDEEM VOUCHER INI') {
      Fluttertoast.showToast(
        msg: GlobalVar.listRedeemVoucher[0].resultMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[850],
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      Fluttertoast.showToast(
        msg: GlobalVar.listRedeemVoucher[0].resultMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[850],
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _togglePopupVisibility,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.12,
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              top: 7.5,
              bottom: 7.5,
            ),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
              border: Border.all(
                // color: const Color(0xFFF59842),
                // color: const Color(0xFF99CCFF),
                color: const Color(0xFFFE0000),
                width: 3,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align vertically
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          widget.list.pointName,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '${widget.list.pointQty.toString()} points',
                          style: const TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: Icon(Icons.arrow_drop_down_circle_rounded),
                ),
              ],
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200), // Add animation
          height: _isPopupVisible
              ? MediaQuery.of(context).size.height * 0.065
              : 0, // Control height based on state
          width: MediaQuery.of(context).size.width * 0.95,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 5.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // backgroundColor: const Color(0xFFF59842),
                      // backgroundColor: const Color(0xFF99CCFF),
                      backgroundColor: const Color(0xFFFE0000),
                    ),
                    onPressed: () {
                      // Handle button tap
                      redeemVoucher();
                    },
                    child: const Text(
                      'Redeem',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              // Expanded(
              //   child: Container(
              //     margin: const EdgeInsets.only(left: 5.0),
              //     // width: MediaQuery.of(context).size.width * 0.9 / 2,
              //     // padding: const EdgeInsets.all(10),
              //     // decoration: BoxDecoration(
              //     //   color: Colors.white,
              //     //   borderRadius: BorderRadius.circular(5),
              //     //   border: Border.all(color: Colors.orange),
              //     // ),
              //     child: ElevatedButton(
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: const Color(0xFFF59842),
              //       ),
              //       onPressed: () {
              //         // Handle button tap
              //       },
              //       child: const Text("Redeem"),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
