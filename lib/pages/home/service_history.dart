import 'dart:convert';

import 'package:fixupmoto/pages/home/modify_vehicle.dart';
import 'package:fixupmoto/widget/image/customimage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fixupmoto/global/api.dart';
import 'package:fixupmoto/global/global.dart';
import 'package:fixupmoto/global/model.dart';
import 'package:fixupmoto/indicator/progress%20bar/circleloading.dart';
import 'package:fixupmoto/pages/home/service_history_details.dart';
import 'package:fixupmoto/widget/format.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ServiceHistory extends StatefulWidget {
  ServiceHistory(this.index, {super.key});

  int index;

  @override
  State<ServiceHistory> createState() => _ServiceHistoryState();
}

class _ServiceHistoryState extends State<ServiceHistory> {
  List<ModelServiceHistoryDetail1> detail1 = [];
  List<ModelServiceHistoryDetail2> detail2 = [];
  bool isLoadingHistory = false;

  void getServiceHistory() async {
    setState(() => isLoadingHistory = true);
    GlobalVar.listServiceHistory = await GlobalAPI.fetchGetService(
      widget.index,
    );
    setState(() => isLoadingHistory = false);

    if (GlobalVar.listServiceHistory.isEmpty) {
      Fluttertoast.showToast(
        msg:
            'Kendaraan dengan plat nomor ${GlobalVar.listVehicle[widget.index].plateNumber} tidak mempunyai riwayat service.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  void getVehicle() async {
    GlobalVar.listVehicle = await GlobalAPI.fetchGetVehicle();
    // print('Vehicle List Length: ${GlobalVar.listVehicle.length}');
  }

  void editVehicle(int mode, {int index = 0}) async {
    if (mode == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ModifyVehicle(
            1,
            getVehicle,
          ),
        ),
      );
    } else if (mode == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ModifyVehicle(
            2,
            getVehicle,
            index: index,
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    getServiceHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Riwayat Service',
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
      body: (isLoadingHistory == true)
          ? const Center(child: CircleLoading())
          : Wrap(
              alignment: WrapAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.01,
                  ),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    ),
                    color: Color(0xFFFE0000),
                  ),
                  child: Column(
                    children: [
                      (GlobalVar.listVehicle[widget.index].photo == '')
                          ? CustomImage(
                              image: Image.asset(
                                'assets/bike-removebg.png',
                                width: 130,
                                height: 130,
                              ),
                              isIcon: true,
                            )
                          : CustomImage(
                              image: Image.memory(
                                base64Decode(
                                    GlobalVar.listVehicle[widget.index].photo),
                                width: MediaQuery.of(context).size.width * 0.25,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                              ),
                              width: MediaQuery.of(context).size.width * 0.7,
                            ),
                      Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: (GlobalVar.listVehicle[widget.index].color ==
                                '-')
                            ? Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        GlobalVar
                                            .listVehicle[widget.index].unitID,
                                        style: GlobalFont.middlegiantfontM,
                                      ),
                                      IconButton(
                                        onPressed: () => editVehicle(
                                          2,
                                          index: widget.index,
                                        ),
                                        icon: const Icon(
                                          Icons.edit,
                                          size: 23.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    GlobalVar
                                        .listVehicle[widget.index].plateNumber,
                                    style: GlobalFont.middlegiantfontM,
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${GlobalVar.listVehicle[widget.index].unitID} - ${GlobalVar.listVehicle[widget.index].color}',
                                        style: GlobalFont.middlegiantfontM,
                                      ),
                                      IconButton(
                                        onPressed: () => editVehicle(
                                          2,
                                          index: widget.index,
                                        ),
                                        icon: const Icon(
                                          Icons.edit,
                                          size: 23.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    GlobalVar
                                        .listVehicle[widget.index].plateNumber,
                                    style: GlobalFont.middlegiantfontM,
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.55,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 10.0),
                        for (int i = 0;
                            i < GlobalVar.listServiceHistory.length;
                            i++)
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ServiceHistoryDetails(i),
                                ),
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height:
                                  MediaQuery.of(context).size.height * 0.135,
                              margin: const EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                                top: 5.0,
                                bottom: 5.0,
                              ),
                              decoration: BoxDecoration(
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      decoration: const BoxDecoration(
                                        // color: Color(0xFFF59842),
                                        // color: Color(0xFF99CCFF),
                                        color: Color(0xFFFE0000),
                                      ),
                                      child: Image(
                                        image: const AssetImage(
                                          './assets/dealer-default.png',
                                        ),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5.0),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start, // Align vertically
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            GlobalVar.listServiceHistory[i]
                                                .workshopName,
                                            style: const TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        // Add space between texts
                                        const SizedBox(height: 5.0),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            Format.tanggalFormat(
                                              GlobalVar.listServiceHistory[i]
                                                  .transDate,
                                            ),
                                            style:
                                                const TextStyle(fontSize: 15.5),
                                          ),
                                        ),
                                        // Add space between texts
                                        const SizedBox(height: 5.0),
                                        Expanded(
                                          flex: 1,
                                          child: Row(
                                            children: [
                                              const Text(
                                                'Biaya Service',
                                                style: TextStyle(fontSize: 14),
                                              ),
                                              const SizedBox(width: 40.0),
                                              Text(
                                                'Rp. ${NumberFormat('###,###.##').format(GlobalVar.listServiceHistory[i].serviceAmount).toString()}',
                                                textAlign: TextAlign.right,
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Row(
                                            children: [
                                              const Text(
                                                'Biaya Spare Part',
                                                style: TextStyle(fontSize: 14),
                                              ),
                                              const SizedBox(width: 20.0),
                                              Text(
                                                'Rp. ${NumberFormat('###,###.##').format(GlobalVar.listServiceHistory[i].partAmount).toString()}',
                                                textAlign: TextAlign.right,
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Add space between texts
                                      ],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    // color: Color(0xFFF59842),
                                    // color: Color(0xFF99CCFF),
                                    color: Color(0xFFFE0000),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.0125,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
