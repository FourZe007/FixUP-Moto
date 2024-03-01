import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
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

  void setDate(String value) {
    date = value;
  }

  void setModelName(String value) {
    GlobalVar.setVehicle = value;
    print(GlobalVar.setVehicle);
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

  void submitBook() async {
    modelName = GlobalVar.setVehicle.split(' - ')[0];
    plateNumber = GlobalVar.setVehicle.split(' - ')[1];
    print('Cabang - ${widget.dealerName}');
    print('Nama Member: ${GlobalVar.listUserData[0].memberName}');
    print('Telepon Member: ${GlobalVar.listUserData[0].phoneNumber}');
    print('Tanggal: $date');
    print('Model Kendaraan: $modelName');
    print('Pukul: $pukul');
    print('Plat Nomor: $plateNumber');
    print('Komplain: $complaint');

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

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  void setVehicle() async {
    GlobalVar.listSetVehicle = await GlobalAPI.fetchSetVehicle();
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
    setVehicle();

    return WillPopScope(
      onWillPop: () async {
        // Prevent the default back button behavior
        return true;
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
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.grey[200],
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin:
                      const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
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
                        height: MediaQuery.of(context).size.height * 0.0125,
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
                        listData: GlobalVar.listSetVehicle,
                        inputan: GlobalVar.listSetVehicle[0]['value'],
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
                  margin: const EdgeInsets.only(left: 25.0, right: 25.0),
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
                          controller: TextEditingController(text: complaint),
                          onChanged: (newValues) => setComplaint(newValues),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.0225,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 25.0, right: 25.0),
                  height: MediaQuery.of(context).size.height * 0.17,
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Tombol(
                        'BOOK NOW!',
                        submitBook,
                        lebar: MediaQuery.of(context).size.width * 0.85,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.0225,
                ),
              ],
            ),
          ),
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
