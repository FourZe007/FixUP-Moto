// ignore_for_file: use_build_context_synchronously, duplicate_ignore
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
// import 'package:fixupmoto/account/term_condition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fixupmoto/global/api.dart';
import 'package:fixupmoto/global/global.dart';
import 'package:fixupmoto/global/model.dart';
import 'package:fixupmoto/indicator/progress%20bar/circleloading.dart';
import 'package:fixupmoto/widget/button/button.dart';
import 'package:fixupmoto/widget/label_title_static.dart';
import 'package:fixupmoto/widget/textfield.dart/customxuserinput.dart';
import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Register extends StatefulWidget {
  Register(this.isVerified, {super.key});

  bool isVerified;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email = '';
  String name = '';
  // String phone = '';
  String password = '';
  // String otp = '';
  // String verify = '';
  bool isVerified = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  bool isLoading = false;

  // EmailOTP myauth = EmailOTP();
  int randomNumber = 0;

  // ModelSendOTP mapSendOTP = ModelSendOTP(resultMessage: '');

  List<ModelUser> listLogin = [];

  void setEmail(String value) {
    print('Email Before: $email');
    email = value;
    print('Email After: $email');
  }

  void setName(String value) {
    print('Name Before: $name');
    name = value;
    print('Name After: $name');
  }

  void getPhone() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    GlobalUser.phone = prefs.getString('phonenumber');
  }

  void setPass(String value) {
    password = value;
  }

  void register() async {
    print('Name: $name');
    print('Password: $password');
    print('Phone Number: ${GlobalUser.phone}');
    print('Email: $email');
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => const TermsAndConditions(),
    //   ),
    // );

    // Terms and Conditions
    // GlobalFunction.tampilkanDialog(
    //   context,
    //   true,
    //   SingleChildScrollView(
    //     child: Container(
    //       width: MediaQuery.of(context).size.width,
    //       margin: EdgeInsets.only(
    //         left: MediaQuery.of(context).size.width * 0.05,
    //         right: MediaQuery.of(context).size.width * 0.05,
    //         top: MediaQuery.of(context).size.height * 0.025,
    //         bottom: MediaQuery.of(context).size.height * 0.01,
    //       ),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           // DEFINISI
    //           Text(
    //             'A. DEFINISI',
    //             style: GlobalFont.bigfontM,
    //           ),
    //           SizedBox(
    //             height: MediaQuery.of(context).size.height * 0.01,
    //           ),
    //           Padding(
    //             padding: EdgeInsets.only(
    //               left: MediaQuery.of(context).size.width * 0.04,
    //             ),
    //             child: Text(
    //               '1. myFixUP adalah sarana untuk melakukan booking service atas akun pengguna dan memperoleh info produk dan/atau layanan FixUp Moto melalui browser dan/atau aplikasi mobile yang dapat di-download dari media distribusi aplikasi/software resmi yang ditunjuk FixUp Moto yang dimiliki oleh mobile operating system yang terdapat di gadget Pengguna.',
    //               style: GlobalFont.middlebigfontM,
    //             ),
    //           ),
    //           SizedBox(
    //             height: MediaQuery.of(context).size.height * 0.005,
    //           ),
    //           Padding(
    //             padding: EdgeInsets.only(
    //               left: MediaQuery.of(context).size.width * 0.04,
    //             ),
    //             child: Text(
    //               '2. myFixUP versi mobile adalah myFixUP yang diakses melalui aplikasi mobile.',
    //               style: GlobalFont.middlebigfontM,
    //             ),
    //           ),
    //           SizedBox(
    //             height: MediaQuery.of(context).size.height * 0.005,
    //           ),
    //           Padding(
    //             padding: EdgeInsets.only(
    //               left: MediaQuery.of(context).size.width * 0.04,
    //             ),
    //             child: Text(
    //               '3. myFixUP versi website adalah myFixUP yang diakses melalui URL https://saptaajimp.com/fixupmoto pada browser.',
    //               style: GlobalFont.middlebigfontM,
    //             ),
    //           ),
    //           SizedBox(
    //             height: MediaQuery.of(context).size.height * 0.005,
    //           ),
    //           Padding(
    //             padding: EdgeInsets.only(
    //               left: MediaQuery.of(context).size.width * 0.04,
    //             ),
    //             child: Text(
    //               '4. FixUP Number adalah username berupa nomor telepon yang diciptakan oleh Pengguna yang terdiri dari 10 sampai 12 digit angka yang dapat digunakan untuk mengakses e-channel FixUp Moto yang ditentukan oleh FixUp Moto.',
    //               style: GlobalFont.middlebigfontM,
    //             ),
    //           ),
    //           SizedBox(
    //             height: MediaQuery.of(context).size.height * 0.005,
    //           ),
    //           Padding(
    //             padding: EdgeInsets.only(
    //               left: MediaQuery.of(context).size.width * 0.04,
    //             ),
    //             child: Text(
    //               '5. Password FixUP Number adalah kata sandi pribadi yang diciptakan dan wajib dimasukkan pengguna FixUP Number untuk dapat menggunakan FixUP Number.',
    //               style: GlobalFont.middlebigfontM,
    //             ),
    //           ),
    //           SizedBox(
    //             height: MediaQuery.of(context).size.height * 0.005,
    //           ),
    //           Padding(
    //             padding: EdgeInsets.only(
    //               left: MediaQuery.of(context).size.width * 0.04,
    //             ),
    //             child: Text(
    //               '6. Kode Transaksi adalah suatu kode yang dihasilkan oleh myFixUP untuk melakukan booking service di bengkel cabang FixUP Moto.',
    //               style: GlobalFont.middlebigfontM,
    //             ),
    //           ),
    //           SizedBox(
    //             height: MediaQuery.of(context).size.height * 0.005,
    //           ),
    //           Padding(
    //             padding: EdgeInsets.only(
    //               left: MediaQuery.of(context).size.width * 0.04,
    //             ),
    //             child: Text(
    //               '7. OTP (One Time Password) adalah kode sandi yang bersifat unik dan rahasia yang dihasilkan oleh sistem FixUP Moto dan dikirimkan melalui SMS ke FixUP Number / nomor handphone yang telah terdaftar dalam database FixUP Number / nomor handphone e-banking FixUP Moto.',
    //               style: GlobalFont.middlebigfontM,
    //             ),
    //           ),
    //           SizedBox(
    //             height: MediaQuery.of(context).size.height * 0.005,
    //           ),
    //           Padding(
    //             padding: EdgeInsets.only(
    //               left: MediaQuery.of(context).size.width * 0.04,
    //             ),
    //             child: Text(
    //               '8. Pengguna adalah perorangan yang memiliki akun myFixUP.',
    //               style: GlobalFont.middlebigfontM,
    //             ),
    //           ),
    //           SizedBox(
    //             height: MediaQuery.of(context).size.height * 0.005,
    //           ),
    //           Padding(
    //             padding: EdgeInsets.only(
    //               left: MediaQuery.of(context).size.width * 0.04,
    //             ),
    //             child: Text(
    //               '9. Quick Response Code atau QR Code adalah kode dua dimensi yang terdiri atas penanda tiga pola persegi pada sudut kiri bawah, sudut kiri atas, dan sudut kanan atas, memiliki modul hitam berupa persegi titik atau piksel, dan memiliki kemampuan menyimpan data alfanumerik, karakter, dan simbol.',
    //               style: GlobalFont.middlebigfontM,
    //             ),
    //           ),
    //           SizedBox(
    //             height: MediaQuery.of(context).size.height * 0.01,
    //           ),
    //           // REGISTRASI
    //           Text(
    //             'B. REGISTRASI myFixUP',
    //             style: GlobalFont.bigfontM,
    //           ),
    //           SizedBox(
    //             height: MediaQuery.of(context).size.height * 0.01,
    //           ),
    //           Padding(
    //             padding: EdgeInsets.only(
    //               left: MediaQuery.of(context).size.width * 0.04,
    //             ),
    //             child: Text(
    //               '1. Untuk dapat menggunakan myFixUP versi mobile, Pengguna wajib:',
    //               style: GlobalFont.middlebigfontM,
    //             ),
    //           ),
    //           SizedBox(
    //             height: MediaQuery.of(context).size.height * 0.007,
    //           ),
    //           Padding(
    //             padding: EdgeInsets.only(
    //               left: MediaQuery.of(context).size.width * 0.08,
    //             ),
    //             child: Text(
    //               'a. memiliki SIM Card Operator Seluler tertentu;',
    //               style: GlobalFont.middlebigfontM,
    //             ),
    //           ),
    //           SizedBox(
    //             height: MediaQuery.of(context).size.height * 0.005,
    //           ),
    //           Padding(
    //             padding: EdgeInsets.only(
    //               left: MediaQuery.of(context).size.width * 0.08,
    //             ),
    //             child: Text(
    //               'b. memiliki nomor handphone yang telah terdaftar dalam database nomor handphone e-booking FixUP Moto;',
    //               style: GlobalFont.middlebigfontM,
    //             ),
    //           ),
    //           SizedBox(
    //             height: MediaQuery.of(context).size.height * 0.005,
    //           ),
    //           Padding(
    //             padding: EdgeInsets.only(
    //               left: MediaQuery.of(context).size.width * 0.08,
    //             ),
    //             child: Row(
    //               children: [
    //                 Text(
    //                   'c. meng-',
    //                   style: GlobalFont.middlebigfontM,
    //                 ),
    //                 Text(
    //                   'install',
    //                   style: GlobalFont.middlebigfontMItalic,
    //                 ),
    //                 Text(
    //                   ' myFixUP;',
    //                   style: GlobalFont.middlebigfontM,
    //                 ),
    //               ],
    //             ),
    //           ),
    //           SizedBox(
    //             height: MediaQuery.of(context).size.height * 0.005,
    //           ),
    //           Padding(
    //             padding: EdgeInsets.only(
    //               left: MediaQuery.of(context).size.width * 0.08,
    //             ),
    //             child: Text(
    //               'd. membuat FixUP Number dan Password FixUP Number;',
    //               style: GlobalFont.middlebigfontM,
    //             ),
    //           ),
    //           SizedBox(
    //             height: MediaQuery.of(context).size.height * 0.005,
    //           ),
    //           Padding(
    //             padding: EdgeInsets.only(
    //               left: MediaQuery.of(context).size.width * 0.08,
    //             ),
    //             child: Text(
    //               'e. melakukan login menggunakan FixUP Number dan Password FixUP Number;',
    //               style: GlobalFont.middlebigfontM,
    //             ),
    //           ),
    //           SizedBox(
    //             height: MediaQuery.of(context).size.height * 0.005,
    //           ),
    //           Padding(
    //             padding: EdgeInsets.only(
    //               left: MediaQuery.of(context).size.width * 0.08,
    //             ),
    //             child: Text(
    //               'f. melalui proses verifikasi sesuai ketentuan yang berlaku di FixUP Moto;',
    //               style: GlobalFont.middlebigfontM,
    //             ),
    //           ),
    //           SizedBox(
    //             height: MediaQuery.of(context).size.height * 0.01,
    //           ),
    //           Padding(
    //             padding: EdgeInsets.only(
    //               left: MediaQuery.of(context).size.width * 0.04,
    //             ),
    //             child: Text(
    //               '2. Untuk dapat menggunakan myFixUP versi website, Pengguna wajib:',
    //               style: GlobalFont.middlebigfontM,
    //             ),
    //           ),
    //           SizedBox(
    //             height: MediaQuery.of(context).size.height * 0.007,
    //           ),
    //           Padding(
    //             padding: EdgeInsets.only(
    //               left: MediaQuery.of(context).size.width * 0.08,
    //             ),
    //             child: Text(
    //               'a. mengakses https://saptaajimp.com/fixupmoto',
    //               style: GlobalFont.middlebigfontM,
    //             ),
    //           ),
    //           SizedBox(
    //             height: MediaQuery.of(context).size.height * 0.005,
    //           ),
    //           // KETENTUAN PENGGUNAAN
    //           Text(
    //             'C. KETENTUAN PENGGUNAAN',
    //             style: GlobalFont.bigfontM,
    //           ),
    //           SizedBox(
    //             height: MediaQuery.of(context).size.height * 0.005,
    //           ),
    //           Padding(
    //             padding: EdgeInsets.only(
    //               left: MediaQuery.of(context).size.width * 0.04,
    //             ),
    //             child: Text(
    //               '1. Setelah Pengguna selesai melakukan registrasi myFixUP, Pengguna dapat menggunakan myBCA untuk melakukan booking service di bengkel cabang FixUP Moto dan memperoleh info produk dan/atau layanan FixUP Moto.',
    //               style: GlobalFont.middlebigfontM,
    //             ),
    //           ),
    //           SizedBox(
    //             height: MediaQuery.of(context).size.height * 0.005,
    //           ),
    //           Padding(
    //             padding: EdgeInsets.only(
    //               left: MediaQuery.of(context).size.width * 0.04,
    //             ),
    //             child: Text(
    //               '2. FixUP Moto berhak melakukan verifikasi terhadap Pengguna yang mengakses atau melakukan transaksi pada myFixUP, antara lain dengan melakukan verifikasi data diri Pengguna dan/atau meminta Nasabah untuk memasukkan OTP saat melakukan transaksi tertentu pada myFixUP.',
    //               style: GlobalFont.middlebigfontM,
    //             ),
    //           ),
    //           SizedBox(
    //             height: MediaQuery.of(context).size.height * 0.005,
    //           ),
    //           Padding(
    //             padding: EdgeInsets.only(
    //               left: MediaQuery.of(context).size.width * 0.04,
    //             ),
    //             child: Text(
    //               '3. Pengguna harus mengisi semua data yang dibutuhkan untuk setiap transaksi finansial secara benar dan lengkap.',
    //               style: GlobalFont.middlebigfontM,
    //             ),
    //           ),
    //           SizedBox(
    //             height: MediaQuery.of(context).size.height * 0.005,
    //           ),
    //           Padding(
    //             padding: EdgeInsets.only(
    //               left: MediaQuery.of(context).size.width * 0.04,
    //             ),
    //             child: Text(
    //               '4. Setiap instruksi dari Pengguna yang tersimpan pada pusat data FixUP Moto merupakan data yang benar dan mengikat Pengguna, serta merupakan bukti yang sah atas instruksi dari Pengguna kepada FixUP Moto untuk melakukan transaksi yang dimaksud, kecuali Pengguna dapat membuktikan sebaliknya.',
    //               style: GlobalFont.middlebigfontM,
    //             ),
    //           ),
    //           // Text(''),
    //           // Text(
    //           //   'Please read the following terms and conditions carefully before continuing.',
    //           //   style: TextStyle(fontSize: 16),
    //           // ),
    //           // SizedBox(height: 16),
    //           // Text(
    //           //   '[Your detailed terms and conditions text here]',
    //           //   style: TextStyle(fontSize: 14),
    //           // ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );

    // create account using API
    if (name != '' &&
        GlobalUser.phone != '' &&
        widget.isVerified != false &&
        password != '') {
      setState(() => isLoading = true);
      if (email == '') {
        email = '-';
      }

      GlobalVar.listRegister = await GlobalAPI.modifyAccount(
        '1',
        '',
        name,
        password,
        GlobalUser.phone!,
        email,
        '',
      );

      setState(() {
        GlobalVar.registerAlert = "Account created!";
      });

      listLogin = await GlobalAPI.loginAccount(GlobalUser.phone!, password);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('password', password);
      await prefs.setString('id', listLogin[0].memberID);
      await prefs.setBool('userstate', true);

      if (listLogin[0].flag == 0) {
        GlobalUser.flag = 0;
        await prefs.setInt('flag', 0);
      } else {
        GlobalUser.flag = 1;
        await prefs.setInt('flag', 1);
      }
      setState(() => isLoading = false);
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      setState(() {
        GlobalVar.registerAlert = "Check your input again";
      });
    }
  }

  @override
  void initState() {
    GlobalVar.registerAlert = '';
    // TODO: implement initState
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    GlobalVar.registerAlert = '';
    name = '';
    email = '';
    password = '';
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DoubleTapToExit(
      snackBar: SnackBar(
        /// need to set following properties for best effect of awesome_snackbar_content
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'WARNING!',
          message: 'Tap again to exit',

          /// change contentType to ContentType.success,
          /// ContentType.warning or ContentType.help for variants
          contentType: ContentType.warning,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Container(
              width: 15.0,
              height: 15.0,
              margin: const EdgeInsets.only(top: 10.0, left: 10.0),
              padding: const EdgeInsets.only(left: 8.0),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                //replace with our own icon data.
              ),
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('./assets/login-background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.725,
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.025,
                              ),
                              child: LabelTitleStatic(
                                'REGISTRATION',
                                GlobalFont.titleLoginFontW2,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.04,
                              ),
                              child: const Text(
                                'Please complete your identity',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomUserInput(
                              setName,
                              name,
                              mode: 0,
                              hint: 'nama *',
                              isCapital: true,
                              icon: Icons.person_rounded,
                              isIcon: true,
                              autoFocus: true,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomUserInput(
                              setEmail,
                              email,
                              mode: 0,
                              hint: 'email',
                              icon: Icons.mail_rounded,
                              isIcon: true,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomUserInput(
                              setPass,
                              password,
                              mode: 0,
                              hint: 'password *',
                              isPass: true,
                              icon: Icons.lock,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.035,
                              ),
                              child: Text(
                                GlobalVar.registerAlert,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.125,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GlobalVar.isLoading
                                ? const CircleLoading()
                                : Tombol(
                                    'SIGN UP',
                                    register,
                                    lebar:
                                        MediaQuery.of(context).size.width * 0.9,
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
