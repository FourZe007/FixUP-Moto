import 'package:fixupmoto/global/global.dart';
import 'package:fixupmoto/widget/format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PointsHistory extends StatefulWidget {
  const PointsHistory({super.key});

  @override
  State<PointsHistory> createState() => _PointsHistoryState();
}

class _PointsHistoryState extends State<PointsHistory> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Points History',
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
              padding: const EdgeInsets.only(
                top: 30.0,
                bottom: 20.0,
              ),
              alignment: Alignment.center,
              // width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.width / 6,
              // color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Your Points',
                    style: TextStyle(
                      fontSize: 23.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${GlobalVar.listUserData[0].points} pts',
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            for (int i = 0; i < GlobalVar.listUserData[0].detail.length; i++)
              Container(
                height: MediaQuery.of(context).size.height * 0.115,
                margin: const EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                  top: 5.0,
                  bottom: 5.0,
                ),
                padding: const EdgeInsets.only(left: 15.0),
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
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.01,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  GlobalVar.listUserData[0].detail[i].pointName,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                Format.tanggalFormat(
                                  GlobalVar.listUserData[0].detail[i].transDate,
                                ),
                                style: const TextStyle(
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        '${GlobalVar.listUserData[0].detail[i].pointQty.toString()} pts',
                        style: const TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
