import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:fixupmoto/global/model.dart';
import 'package:fixupmoto/indicator/progress%20bar/circleloading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fixupmoto/global/api.dart';
import 'package:fixupmoto/global/global.dart';
import 'package:fixupmoto/widget/button/button.dart';
import 'package:fixupmoto/widget/custom_date_picker.dart';
import 'package:fixupmoto/widget/dropdown/customdropdown.dart';
import 'package:fixupmoto/widget/dropdown/timeasset_user.dart';

// ignore: must_be_immutable
class ServiceBooking extends StatefulWidget {
  ServiceBooking(this.dealerName, {super.key});

  String dealerName;

  @override
  State<ServiceBooking> createState() => _ServiceBookingState();
}

class _ServiceBookingState extends State<ServiceBooking> {
  String date = '';
  String modelName = '';
  String pukul = '09:00';
  String plateNumber = '';
  String complaint = '';

  bool isEmpty = false;

  List<Map<String, dynamic>> listVehicle = [];
  String vehicle = '';

  ModelSendOTP mapSendOTP = ModelSendOTP(resultMessage: '');

  void setDate(String value) {
    date = value;
  }

  void setModelName(String value) {
    vehicle = value;
    print(vehicle);
  }

  void setPukul(String value) {
    pukul = value;
  }

  void setPlateNumber(String value) {
    plateNumber = value;
  }

  void setComplaint(String value) {
    complaint = value;
  }

  void submitBook(BuildContext context) async {
    modelName = vehicle.split(' - ')[0];
    plateNumber = vehicle.split(' - ')[1];
    // print('Cabang - ${widget.dealerName}');
    // print('Nama Member: ${GlobalVar.listUserData[0].memberName}');
    // print('Telepon Member: ${GlobalVar.listUserData[0].phoneNumber}');
    // print('Tanggal: $date');
    // print('Model Kendaraan: $modelName');
    // print('Pukul: $pukul');
    // print('Plat Nomor: $plateNumber');
    // print('Komplain: $complaint');

    GlobalVar.listReqBook = await GlobalAPI.fetchInsertBookReq(
      '1',
      '',
      date,
      pukul,
      '31',
      (widget.dealerName == 'FixUP MOTO - KUTISARI') ? '01' : '02',
      GlobalVar.listUserData[0].memberName,
      GlobalVar.listUserData[0].phoneNumber,
      plateNumber,
      modelName,
      complaint,
      '',
      '',
    );

    // ignore: use_build_context_synchronously
    Navigator.pop(context);

    final snackBar = SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Please keep your booking ID',
        message: GlobalVar.listReqBook[0].resultMessage,

        /// change contentType to ContentType.success,
        /// ContentType.warning or ContentType.help for variants
        contentType: ContentType.success,
      ),
    );

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);

    String message =
        '[FIXUP MOTO] ${GlobalVar.listReqBook[0].resultMessage} adalah kode booking Anda. Demi Keamanan, jangan bagikan kode ini dan mohon disimpan.';

    mapSendOTP = await GlobalAPI.fetchSendOTP(
      '62${GlobalUser.phone}',
      message,
      'poco-phone',
      // 'realme-tab',
      'text',
    );
  }

  Stream<List<Map<String, dynamic>>> setVehicle() async* {
    listVehicle = await GlobalAPI.fetchSetVehicle();
    print('List Vehicle: $listVehicle');
    yield listVehicle;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final today = DateTime.now();
    final nextTwoDays = today.add(const Duration(days: 1));
    date = nextTwoDays.toString().split(' ')[0];

    modelName = '';
    pukul = '09:00';
    plateNumber = '';
    complaint = '';

    if (GlobalVar.listUserData.isEmpty) {
      isEmpty = true;
    } else {
      isEmpty = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Service Booking',
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
        body: StreamBuilder(
          stream: setVehicle(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircleLoading());
            } else if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.89,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          left: 25.0,
                          right: 25.0,
                          top: 25.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Nama Bengkel',
                              style: TextStyle(fontSize: 15.0),
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              widget.dealerName,
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.0125,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 25.0, right: 25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Nama',
                              style: TextStyle(fontSize: 15.0),
                            ),
                            const SizedBox(height: 5.0),
                            Text(
                              GlobalVar.listUserData.isNotEmpty
                                  ? GlobalVar.listUserData[0].memberName
                                  : '',
                              style: GlobalFont.giantfontR,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.0125,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 25.0, right: 25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Nomor Telepon',
                              style: TextStyle(fontSize: 15.0),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.0125,
                            ),
                            Text(
                              GlobalVar.listUserData.isNotEmpty
                                  ? '0${GlobalVar.listUserData[0].phoneNumber}'
                                  : '',
                              style: GlobalFont.giantfontR,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.0225,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 25.0, right: 25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tanggal',
                              style: TextStyle(fontSize: 15.0),
                            ),
                            const SizedBox(height: 5.0),
                            CustomDatetimePicker(
                              date,
                              setDate,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.0225,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 25.0, right: 25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Pukul',
                              style: TextStyle(fontSize: 15.0),
                            ),
                            const SizedBox(height: 5.0),
                            UserTimeAsset(
                              setPukul,
                              pukul,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.0225,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 25.0, right: 25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Model Kendaraan',
                              style: TextStyle(fontSize: 15.0),
                            ),
                            const SizedBox(height: 5.0),
                            CustomDropDown(
                              listData: snapshot.data!,
                              inputan: snapshot.data![0]['value'],
                              disable: (isEmpty) ? true : false,
                              hint: 'kendaraan',
                              handle: setModelName,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.0225,
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          left: 25.0,
                          right: 25.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Keluhan',
                              style: TextStyle(fontSize: 15.0),
                            ),
                            const SizedBox(height: 5.0),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white,
                              ),
                              child: TextField(
                                inputFormatters: [UpperCaseText()],
                                decoration: const InputDecoration(
                                  hintText: 'Masukkan keluhan',
                                  border: InputBorder.none,
                                ),
                                controller:
                                    TextEditingController(text: complaint),
                                onChanged: (newValues) =>
                                    setComplaint(newValues),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.0725,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 25.0, right: 25.0),
                        height: MediaQuery.of(context).size.height * 0.05,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Tombol(
                              'BOOK NOW!',
                              () => submitBook(context),
                              lebar: MediaQuery.of(context).size.width * 0.85,
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height:
                      //       MediaQuery.of(context).size.height * 0.0225,
                      // ),
                    ],
                  ),
                ),
              );
            }
            return SnackBar(
              content: Text(
                'Data not Found',
                style: GlobalFont.giantfontM,
              ),
            );
          },
        ),
      ),
    );
  }
}

class UpperCaseText extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
