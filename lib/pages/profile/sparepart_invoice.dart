import 'dart:developer';

import 'package:fixupmoto/global/api.dart';
import 'package:fixupmoto/global/global.dart';
import 'package:fixupmoto/indicator/progress%20bar/circleloading.dart';
import 'package:fixupmoto/pages/profile/sparepart_invoice_details.dart';
import 'package:fixupmoto/widget/button/date_filter_button.dart';
import 'package:fixupmoto/widget/format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class SparepartInvoice extends StatefulWidget {
  const SparepartInvoice({super.key});

  @override
  State<SparepartInvoice> createState() => _SparepartInvoiceState();
}

class _SparepartInvoiceState extends State<SparepartInvoice> {
  bool isLoading = false;

  String startDate = '';
  String endDate = '';

  void filterdata(String start, String end) async {
    log('Filter Data');
    setState(() => isLoading = true);
    GlobalVar.memberInvoiceList =
        await GlobalAPI.fetchGetMemberInvoice('SPAREPART', start, end);
    setState(() => isLoading = false);

    if (GlobalVar.memberInvoiceList.isEmpty) {
      GlobalVar.memberInvoiceSparePart = [];

      Fluttertoast.showToast(
        msg: 'No data found',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      GlobalVar.memberInvoiceSparePart = [];
      log(GlobalVar.memberInvoiceList.length.toString());
      for (int i = 0; i < GlobalVar.memberInvoiceList.length; i++) {
        if (GlobalVar.memberInvoiceList[i].jenis == 'SPAREPART') {
          GlobalVar.memberInvoiceSparePart.add(GlobalVar.memberInvoiceList[i]);
        }
      }
      setState(() {});
      log(GlobalVar.memberInvoiceSparePart.toString());
    }
  }

  void setStartDate(String date) {
    startDate = date;

    filterdata(startDate, endDate);
  }

  void setEndDate(String date) {
    endDate = date;

    filterdata(startDate, endDate);
  }

  void getData() {
    startDate = DateTime.now().toString().split(' ')[0];
    endDate = DateTime.now().toString().split(' ')[0];
    DateTime currentDate = DateFormat('yyyy-MM-dd').parse(endDate);
    DateTime futureDate = currentDate.add(const Duration(days: 7));
    endDate = DateFormat('yyyy-MM-dd').format(futureDate);

    filterdata(startDate, endDate);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Spare Part Invoice',
          style: GlobalFont.giantfontM,
        ),
        // backgroundColor: const Color(0xFFF59842),
        // backgroundColor: Colors.red,
        // backgroundColor: const Color(0xFF99CCFF),
        backgroundColor: const Color(0xFFFE0000),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          //replace with our own icon data.
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.075,
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.01,
                right: MediaQuery.of(context).size.width * 0.01,
              ),
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.02,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 6,
                    child: Container(
                      alignment: Alignment.center,
                      // height: MediaQuery.of(context).size.height * 0.05,
                      child: Row(
                        children: [
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.filter_alt_rounded,
                                  size: 30.0,
                                ),
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width * 0.01,
                          // ),
                          Expanded(
                            flex: 11,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: (MediaQuery.of(context).size.width > 375)
                                    ? MediaQuery.of(context).size.width * 0.03
                                    : MediaQuery.of(context).size.width * 0.02,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Filters',
                                    style: GlobalFont.giantfontR,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width * 0.05,
                  // ),
                  Expanded(
                    flex: 7,
                    child: DateFilterButton(
                      startDate,
                      setStartDate,
                      false,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.05,
                      margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.025,
                        right: MediaQuery.of(context).size.width * 0.025,
                      ),
                      // const Icon(Icons.horizontal_rule_outlined)
                      child: Text(
                        'to',
                        style: GlobalFont.middlebigfontM,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: DateFilterButton(
                      endDate,
                      setEndDate,
                      false,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.0125,
            ),
            (isLoading == true)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: const CircleLoading(),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      for (int i = 0;
                          i < GlobalVar.memberInvoiceSparePart.length;
                          i++)
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SparepartInvoiceDetails(i),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.02,
                              vertical:
                                  MediaQuery.of(context).size.height * 0.005,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              border: Border.all(
                                // color: const Color(0xFFF59842),
                                // color: Colors.red,
                                // color: const Color(0xFF99CCFF),
                                color: const Color(0xFFFE0000),
                                width: 3,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.125,
                                  width:
                                      MediaQuery.of(context).size.width * 0.15,
                                  decoration: const BoxDecoration(
                                    // color: Colors.red,
                                    // color: Color(0xFF99CCFF),
                                    color: Color(0xFFFE0000),
                                  ),
                                  child: const Icon(
                                    Icons.precision_manufacturing_rounded,
                                    color: Colors.white,
                                    size: 30.0,
                                  ),
                                ),
                                const SizedBox(width: 5.0),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start, // Align vertically
                                      children: [
                                        Text(GlobalVar
                                            .memberInvoiceSparePart[i].transNo),
                                        // Add space between texts
                                        const SizedBox(height: 5.0),
                                        Text(
                                          '${Format.tanggalFormat(GlobalVar.memberInvoiceSparePart[i].transDate)} @${GlobalVar.memberInvoiceSparePart[i].bsName}',
                                        ),
                                        const SizedBox(height: 5.0),
                                        Text(
                                          'Total Nett: ${GlobalVar.memberInvoiceSparePart[i].totalNett.toString()}',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 10.0),
                                  child: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    // color: Color(0xFFF59842),
                                    // color: Colors.red[700],
                                    // color: Color(0xFF99CCFF),
                                    color: Color(0xFFFE0000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
