import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:fixupmoto/global/api.dart';
import 'package:fixupmoto/global/global.dart';
import 'package:fixupmoto/indicator/progress%20bar/circleloading.dart';
import 'package:fixupmoto/pages/profile/service_invoice_details.dart';
import 'package:fixupmoto/widget/button/date_filter_button.dart';
import 'package:fixupmoto/widget/format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ServiceInvoice extends StatefulWidget {
  const ServiceInvoice({super.key});

  @override
  State<ServiceInvoice> createState() => _ServiceInvoiceState();
}

class _ServiceInvoiceState extends State<ServiceInvoice> {
  bool isLoading = false;

  String startDate = '';
  String endDate = '';

  void filterdata(String start, String end) async {
    print('Filter Data');

    setState(() => isLoading = true);
    GlobalVar.memberInvoiceList = [];
    GlobalVar.memberInvoiceList =
        await GlobalAPI.fetchGetMemberInvoice('SERVICE', start, end);
    setState(() => isLoading = false);

    if (GlobalVar.memberInvoiceList.isEmpty) {
      GlobalVar.memberInvoiceService = [];
      final snackBar = SnackBar(
        /// need to set following properties for best effect of awesome_snackbar_content
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Oh Snap!',
          message: 'No data found',

          /// change contentType to ContentType.success,
          /// ContentType.warning or ContentType.help for variants
          contentType: ContentType.failure,
        ),
      );

      Future<void>.delayed(Duration.zero, () {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      });
    } else {
      GlobalVar.memberInvoiceService = [];
      print(GlobalVar.memberInvoiceList.length);
      for (int i = 0; i < GlobalVar.memberInvoiceList.length; i++) {
        if (GlobalVar.memberInvoiceList[i].jenis == 'SERVICE') {
          GlobalVar.memberInvoiceService.add(GlobalVar.memberInvoiceList[i]);
        }
      }
      setState(() {});
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

  void getData() async {
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
    return WillPopScope(
      onWillPop: () async {
        // Prevent the default back button behavior
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Service Invoice',
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
            mainAxisAlignment: MainAxisAlignment.center,
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
                        // height: MediaQuery.of(context).size.height * 0.014,
                        child: Row(
                          children: [
                            const Expanded(
                              child: Icon(
                                Icons.filter_alt_rounded,
                                size: 30.0,
                              ),
                            ),
                            // SizedBox(
                            //   width: MediaQuery.of(context).size.width * 0.01,
                            // ),
                            Expanded(
                              flex: 11,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: (MediaQuery.of(context).size.width >
                                          375)
                                      ? MediaQuery.of(context).size.width * 0.03
                                      : MediaQuery.of(context).size.width *
                                          0.02,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Filters',
                                      style:
                                          (MediaQuery.of(context).size.width >
                                                  375)
                                              ? GlobalFont.giantfontR
                                              : GlobalFont.middlegiantfontR,
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
                    //   width: MediaQuery.of(context).size.width * 0.045,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0;
                            i < GlobalVar.memberInvoiceService.length;
                            i++)
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ServiceInvoiceDetails(i),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.025,
                                right:
                                    MediaQuery.of(context).size.width * 0.025,
                                top: MediaQuery.of(context).size.width * 0.01,
                                bottom:
                                    MediaQuery.of(context).size.width * 0.01,
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
                                        0.15,
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    decoration: const BoxDecoration(
                                      // color: Colors.red,
                                      // color: Color(0xFF99CCFF),
                                      color: Color(0xFFFE0000),
                                    ),
                                    child: const Icon(
                                      Icons.handyman_rounded,
                                      color: Colors.white,
                                      size: 30.0,
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.005,
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start, // Align vertically
                                        children: [
                                          Text(GlobalVar
                                              .memberInvoiceService[i].transNo),
                                          // Add space between texts
                                          const SizedBox(height: 5.0),
                                          Text(
                                            '${Format.tanggalFormat(GlobalVar.memberInvoiceService[i].transDate)} @${GlobalVar.memberInvoiceService[i].bsName}',
                                          ),
                                          const SizedBox(height: 5.0),
                                          Text(
                                            'Total Nett: ${GlobalVar.memberInvoiceService[i].totalNett.toString()}',
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
      ),
    );
  }
}
