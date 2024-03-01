import 'package:flutter/material.dart';
import 'package:fixupmoto/global/global.dart';
import 'package:fixupmoto/widget/format.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ServiceHistoryDetails extends StatefulWidget {
  ServiceHistoryDetails(this.index, {super.key});

  int index;

  @override
  State<ServiceHistoryDetails> createState() => _ServiceHistoryDetailsState();
}

class _ServiceHistoryDetailsState extends State<ServiceHistoryDetails> {
  double grandTotal = 0;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    grandTotal = GlobalVar.listServiceHistory[widget.index].serviceAmount +
        GlobalVar.listServiceHistory[widget.index].partAmount;
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
            'Detail Service',
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
        body: Container(
          margin: const EdgeInsets.fromLTRB(
            10.0,
            15.0,
            10.0,
            15.0,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    GlobalVar.listServiceHistory[widget.index].workshopName,
                    style: GlobalFont.middlegigafontR,
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.065),
              // ~:Nama Teknisi:~
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Nama Teknisi',
                      style: GlobalFont.middlegiantfontR,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    flex: 2,
                    child: Text(
                      GlobalVar.listServiceHistory[widget.index].name,
                      style: GlobalFont.bigfontRNormal,
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              // ~:Tanggal:~
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Tanggal',
                      style: GlobalFont.middlegiantfontR,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.0125,
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      Format.tanggalFormat(
                        GlobalVar.listServiceHistory[widget.index].transDate,
                      ),
                      style: GlobalFont.bigfontRNormal,
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              // ~:Nama Service:~
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nama Service',
                        style: GlobalFont.middlegiantfontR,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      for (var notes
                          in GlobalVar.listServiceHistory[widget.index].detail)
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Text(
                            '- ${notes.serviceNote}',
                            style: GlobalFont.mediumbigfontRNormal,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              // ~:Spare Parts:~
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Spare Parts',
                            style: GlobalFont.middlegiantfontR,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          for (var parts in GlobalVar
                              .listServiceHistory[widget.index].detail2)
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '- ${parts.itemName}',
                                    style: GlobalFont.mediumbigfontR,
                                  ),
                                  Text('  ${parts.unitID}'),
                                  Text('  Qty: ${parts.qty}'),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  // ~:Total Amount:~
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Total Biaya',
                          style: GlobalFont.middlegiantfontR,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Biaya Service',
                          style: GlobalFont.bigfontRNormal,
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Rp.',
                          textAlign: TextAlign.right,
                          style: GlobalFont.bigfontRNormal,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          NumberFormat('###,###.##')
                              .format(GlobalVar.listServiceHistory[widget.index]
                                  .serviceAmount)
                              .toString(),
                          textAlign: TextAlign.right,
                          style: GlobalFont.bigfontRNormal,
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: SizedBox(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Biaya Spare Part',
                          style: GlobalFont.bigfontRNormal,
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Rp.',
                          textAlign: TextAlign.right,
                          style: GlobalFont.bigfontRNormal,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          NumberFormat('###,###.##')
                              .format(GlobalVar
                                  .listServiceHistory[widget.index].partAmount)
                              .toString(),
                          textAlign: TextAlign.right,
                          style: GlobalFont.bigfontRNormal,
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: SizedBox(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Grand Total',
                          style: GlobalFont.bigfontRNormal,
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Rp.',
                          textAlign: TextAlign.right,
                          style: GlobalFont.bigfontRNormal,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          NumberFormat('###,###.##')
                              .format(grandTotal)
                              .toString(),
                          textAlign: TextAlign.right,
                          style: GlobalFont.bigfontRNormal,
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: SizedBox(),
                      ),
                    ],
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
