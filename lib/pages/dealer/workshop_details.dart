import 'package:fixupmoto/global/global.dart';
import 'package:fixupmoto/pages/dealer/workshop_maps.dart';
import 'package:flutter/material.dart';
import 'package:fixupmoto/indicator/progress%20bar/circleloading.dart';
import 'package:fixupmoto/pages/dealer/service_booking.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:fixupmoto/widget/timer/timer.dart';

// ignore: must_be_immutable
class WorkshopDetails extends StatefulWidget {
  WorkshopDetails(this.index, {super.key});

  // String branchName;
  // String address;
  // String operationHour;
  // String phoneNumber;
  int index;

  @override
  State<WorkshopDetails> createState() => _WorkshopDetailsState();
}

class _WorkshopDetailsState extends State<WorkshopDetails> {
  String weekday = '';
  String saturday = '';
  String sunday = '';

  DateTime _currentTime = DateTime.now();
  String currentDay = '';
  int currentHour = 0;
  int currentMinute = 0;

  bool isOpen = false;
  bool isLoading = false;

  void _checkAccess() {
    setState(() => isLoading = true);
    _currentTime = DateTime.now();
    // Get the current day of the week
    currentDay = DateFormat('EEEE').format(_currentTime);
    currentHour = _currentTime.hour;
    currentMinute = _currentTime.minute;

    if (currentDay != 'Sunday') {
      // Check if the current time is between 9am and 5pm
      if ((currentHour >= 9 && currentHour <= 16) && currentMinute <= 59) {
        // print('9 - 17 TRUE');
        isOpen = true;
      } else {
        // print('9 - 17 FALSE');
        isOpen = false;
      }
    } else {
      // Check if the current time is between 9am and 3pm
      if ((currentHour >= 9 && currentHour <= 14) && currentMinute <= 59) {
        isOpen = true;
      } else {
        isOpen = false;
      }
    }

    setState(() => isLoading = false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    print('Coordinate Index: ${widget.index}');

    _checkAccess();

    // print(GlobalVar.listWorkshopDetail[widget.index].operation.split('\n')[0].split('\t')[1].substring(2));
    // print(GlobalVar.listWorkshopDetail[widget.index].operation.split('\n')[1].split('\t')[3].substring(2));
    weekday = GlobalVar.listWorkshopDetail[widget.index].operation
        .split('\n')[0]
        .split('\t')[1]
        .substring(2);
    saturday = GlobalVar.listWorkshopDetail[widget.index].operation
        .split('\n')[0]
        .split('\t')[1]
        .substring(2);
    sunday = GlobalVar.listWorkshopDetail[widget.index].operation
        .split('\n')[1]
        .split('\t')[3]
        .substring(2);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading == true) {
      return const Center(child: CircleLoading());
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            GlobalVar.listWorkshopDetail[widget.index].name,
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
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.topCenter,
              child: Image.asset('./assets/fixup-image-1-cropped.jpg'),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 5 + 25,
                right: MediaQuery.of(context).size.width / 20,
                left: MediaQuery.of(context).size.width / 20,
              ),
              padding: const EdgeInsets.fromLTRB(7.5, 7.5, 7.5, 10.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey, // Adjust shadow color as needed
                    offset: Offset(2.0, 4.0), // Adjust shadow offset
                    blurRadius: 5.0, // Adjust shadow blur radius
                    spreadRadius: 1.0, // Adjust shadow spread radius
                  ),
                ],
              ),
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  TimerPerSec(_checkAccess),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(double.infinity, 50),
                            // backgroundColor: const Color(0xFFF59842),
                            // backgroundColor: const Color(0xFF99CCFF),
                            backgroundColor: const Color(0xFFFE0000),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.00),
                              ),
                            ),
                          ),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ServiceBooking(
                                GlobalVar
                                    .listWorkshopDetail[widget.index].branch,
                              ),
                            ),
                          ),
                          child: const Text(
                            'Service Booking',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.035,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Open',
                                  style: TextStyle(
                                    color: isOpen == true
                                        ? Colors.green
                                        : Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  ' / ',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                                Text(
                                  'Close',
                                  style: TextStyle(
                                    color: isOpen == true
                                        ? Colors.black
                                        : Colors.green,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.0175,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  const Text(
                                    'Operation Hour',
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  const Text(
                                    'Weekday',
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  const Text(
                                    'Saturday',
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  const Text(
                                    'Sunday & Holidays',
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.125,
                              ),
                              Column(
                                children: [
                                  const Text(
                                    'Time (WIB)',
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  Text(
                                    weekday,
                                    style: const TextStyle(fontSize: 15.0),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  Text(
                                    saturday,
                                    style: const TextStyle(fontSize: 15.0),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  Text(
                                    sunday,
                                    style: const TextStyle(fontSize: 15.0),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(
                            height: 50.0,
                            thickness: 1.0,
                            indent: 10,
                            endIndent: 10,
                            color: Colors.grey[400],
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  'Workshop Address',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.023,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  GlobalVar
                                      .listWorkshopDetail[widget.index].address,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            height: 50.0,
                            thickness: 1.0,
                            indent: 10,
                            endIndent: 10,
                            color: Colors.grey[400],
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Contact Information',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.0045,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.009,
                                  ),
                                  const Text(
                                    'Phone Number',
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.125,
                              ),
                              Column(
                                children: [
                                  const SizedBox(height: 8.0),
                                  Text(
                                    GlobalVar.listWorkshopDetail[widget.index]
                                                .phone !=
                                            ''
                                        ? GlobalVar
                                            .listWorkshopDetail[widget.index]
                                            .phone
                                        : 'Unavailable',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      decoration: TextDecoration.underline,
                                      color: GlobalVar
                                                  .listWorkshopDetail[
                                                      widget.index]
                                                  .phone !=
                                              ''
                                          ? Colors.blue
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(
                            height: 50.0,
                            thickness: 1.0,
                            indent: 10,
                            endIndent: 10,
                            color: Colors.grey[400],
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Location',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.0225,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WorkshopMaps(
                                        GlobalVar
                                            .listWorkshopDetail[widget.index]
                                            .latitude,
                                        GlobalVar
                                            .listWorkshopDetail[widget.index]
                                            .longitude,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.75,
                                  height:
                                      MediaQuery.of(context).size.height * 0.25,
                                  margin: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  decoration: BoxDecoration(
                                    image: const DecorationImage(
                                      image: AssetImage(
                                        './assets/Indonesia-Maps-2-removed.png',
                                      ),
                                    ),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15.0),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors
                                            .grey, // Adjust shadow color as needed
                                        offset: Offset(
                                            2.0, 4.0), // Adjust shadow offset
                                        blurRadius:
                                            5.0, // Adjust shadow blur radius
                                        spreadRadius:
                                            1.0, // Adjust shadow spread radius
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.map_rounded),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.0125,
                                      ),
                                      const Text('View Maps'),
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
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}
