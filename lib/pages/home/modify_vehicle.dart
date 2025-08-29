// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:fixupmoto/widget/carousel/vehicle_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fixupmoto/global/api.dart';
import 'package:fixupmoto/global/global.dart';
import 'package:fixupmoto/global/model.dart';
import 'package:fixupmoto/widget/button/button.dart';
import 'package:fixupmoto/widget/image/customimage.dart';
import 'package:fixupmoto/widget/label_title_static.dart';
import 'package:fixupmoto/widget/textfield.dart/customxuserinput.dart';
import 'package:image/image.dart' as images;

// ignore: must_be_immutable
class ModifyVehicle extends StatefulWidget {
  ModifyVehicle(this.mode, this.handle, {this.index = 0, super.key});

  int mode;
  Function handle;
  int index;

  @override
  State<ModifyVehicle> createState() => MmodifyVehicleState();
}

class MmodifyVehicleState extends State<ModifyVehicle> {
  String memberID = '';
  String plateNo = '';
  String unitID = '';
  String chasisNo = '';
  String engineNo = '';
  String color = '';
  String year = '';
  int line = 0;

  XFile? pickedFile;
  String base64Image = '';
  Image? displayImage;

  Color inkColor = Colors.white;

  List<ModelResultMessage> listNewVehicle = [];
  List<ModelVehicleDetail> list = [];

  bool isLarger = false;

  void setMemberID(String value) {
    memberID = value;
  }

  void setPlateNo(String value) {
    plateNo = value;
  }

  void setUnitID(String value) {
    unitID = value;
  }

  void setChasisNo(String value) {
    chasisNo = value;
  }

  void setEngineNo(String value) {
    engineNo = value;
  }

  void setColor(String value) {
    color = value;
  }

  void setYear(String value) {
    year = value;
  }

  void setLine(int value) {
    line = value;
  }

  void uploadImage() async {
    // Pick image from gallery or camera
    pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    // Check if image was picked
    if (pickedFile == null) return null;

    // Read image bytes
    final imageBytes = await pickedFile!.readAsBytes();
    // Resize image (optional)
    images.Image? img = images.decodeImage(imageBytes);

    if ((img!.width == img.height) || (img.width <= img.height)) {
      isLarger = true;
      setState(() {});

      Fluttertoast.showToast(
        msg: 'Please use horizontal image',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[600] ?? Colors.grey[400],
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      isLarger = false;
      images.Image resized = images.copyResize(
        img,
        width: img.width.toInt(),
        height: img.height.toInt(),
      );

      // Encode image to base64
      base64Image = base64Encode(images.encodePng(resized));

      print('base64Image: $base64Image');

      // DISPLAY USER IMAGE
      // Decode base64 string to bytes
      Uint8List bytes = base64Decode(base64Image);

      // Create Image object from bytes
      displayImage = Image.memory(bytes);

      // Display the image
      setState(() {
        displayImage = displayImage; // Update the state with the image
      });
    }
  }

  void submitData() async {
    if (chasisNo == '') {
      setChasisNo('-');
    }
    if (engineNo == '') {
      setEngineNo('-');
    }
    if (color == '') {
      setColor('-');
    }
    if (year == '') {
      setYear('-');
    }

    if (plateNo != '' && unitID != '') {
      print('Mode: ${widget.mode}');
      print('Member ID: ${GlobalVar.listUserData[0].memberID}');
      print('Plate Number: $plateNo');
      print('Unit ID: $unitID');
      print('Chasis Number: $chasisNo');
      print('Engine Number: $engineNo');
      print('Color: $color');
      print('Year: $year');
      if (widget.mode == 1) {
        print('New Image: $base64Image');
      } else if (widget.mode == 2) {
        print('Edit Image: $base64Image');
      }
      print('Line: $line');

      listNewVehicle = await GlobalAPI.fetchModifyVehicle(
        widget.mode.toString(),
        'REGISTERMOTOR',
        GlobalVar.listUserData[0].memberID,
        plateNo,
        unitID,
        chasisNo != '' ? chasisNo : '-',
        engineNo != '' ? engineNo : '-',
        color != '' ? color : '-',
        year != '' ? year : '-',
        base64Image,
        widget.mode == 1 ? 0 : line,
      );

      if (listNewVehicle[0].resultMessage == plateNo) {
        setState(() => GlobalVar.isChange = true);
        // print('Before isChange: ${GlobalVar.isChange}');
        list = await GlobalAPI.fetchGetVehicle();
        VehicleChangeNotifier().notify(list);
        setState(() => GlobalVar.isChange = false);
        // print('After isChange: ${GlobalVar.isChange}');
        // print(
        //     'Newly Updated Data: ${GlobalVar.listVehicle[widget.index].color}');

        Navigator.pop(context);

        Fluttertoast.showToast(
          msg: widget.mode == 1
              ? 'Data Berhasil di Tambah'
              : 'Data Berhasil di Update',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: listNewVehicle[0].resultMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: 'Mohon periksa input anda kembali',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  void insertData() {
    if (widget.mode == 2) {
      // Edit Vehicle Data
      log('Edit Data');

      plateNo = GlobalVar.listVehicle[widget.index].plateNumber;
      unitID = GlobalVar.listVehicle[widget.index].unitID;
      chasisNo = GlobalVar.listVehicle[widget.index].chasisNumber;
      engineNo = GlobalVar.listVehicle[widget.index].engineNumber;
      color = GlobalVar.listVehicle[widget.index].color;
      year = GlobalVar.listVehicle[widget.index].year;
      base64Image = GlobalVar.listVehicle[widget.index].photo;
      line = GlobalVar.listVehicle[widget.index].line;
      log('Line: $line');
      log('Image: $base64Image');
    } else {
      // Insert New Vehicle Data
      log('Insert Data');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    insertData();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    listNewVehicle = [];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    list = [];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent the default back button behavior
        return true;
      },
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              (widget.mode == 1) ? 'Tambah Kendaraan' : 'Edit Kendaraan',
              style: GlobalFont.giantfontM,
            ),
            // backgroundColor: const Color(0xFFF59842),
            // backgroundColor: Colors.red,
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
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LabelTitleStatic(
                      'DATA KENDARAAN',
                      GlobalFont.middlegigafontC,
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.0225,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        uploadImage();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.4,
                        decoration: BoxDecoration(
                          color: Colors.grey[200]!,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.black),
                        ),
                        child: CustomImage(
                          image: (widget.mode == 2 &&
                                  GlobalVar.listVehicle[widget.index].photo !=
                                      '')
                              ? Image.memory(
                                  base64Decode(
                                    GlobalVar.listVehicle[widget.index].photo,
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                )
                              : displayImage,
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.35,
                          borderRadius: 10.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.0225,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomUserInput(
                      setPlateNo,
                      plateNo,
                      isDataAvailable: true,
                      mode: 0,
                      hint: 'plat nomor *',
                      isCapital: true,
                      icon: Icons.credit_card_rounded,
                      isIcon: true,
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.0125,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomUserInput(
                      setUnitID,
                      unitID,
                      isDataAvailable: true,
                      mode: 0,
                      hint: 'tipe kendaraan *',
                      isCapital: true,
                      icon: Icons.directions_car_filled_rounded,
                      isIcon: true,
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.0125,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomUserInput(
                      setChasisNo,
                      chasisNo,
                      isDataAvailable: true,
                      mode: 0,
                      hint: 'nomor chasis',
                      isCapital: true,
                      icon: Icons.numbers_rounded,
                      isIcon: true,
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.0125,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomUserInput(
                      setEngineNo,
                      engineNo,
                      isDataAvailable: true,
                      mode: 0,
                      hint: 'nomor mesin',
                      isCapital: true,
                      icon: Icons.abc_rounded,
                      isIcon: true,
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.0125,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomUserInput(
                      setColor,
                      color,
                      isDataAvailable: true,
                      mode: 0,
                      hint: 'warna',
                      isCapital: true,
                      icon: Icons.color_lens_rounded,
                      isIcon: true,
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.0125,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomUserInput(
                      setYear,
                      year,
                      isDataAvailable: true,
                      mode: 0,
                      hint: 'tahun kendaraan',
                      isCapital: true,
                      icon: Icons.date_range_rounded,
                      isIcon: true,
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.0225,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.025,
                      ),
                      child: Tombol(
                        (widget.mode == 1) ? 'TAMBAH' : 'SIMPAN',
                        submitData,
                        lebar: MediaQuery.of(context).size.width * 0.8,
                      ),
                    ),
                  ],
                ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.0125,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
