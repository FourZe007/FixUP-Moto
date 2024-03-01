import 'package:fixupmoto/global/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  // final ScrollController _scrollController = ScrollController();
  // bool _isScrolledToEnd = false;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    // _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  // void _scrollListener() {
  //   final maxScroll = _scrollController.position.maxScrollExtent;
  //   final currentScroll = _scrollController.offset;
  //   setState(() {
  //     _isScrolledToEnd = currentScroll >=
  //         (maxScroll * 0.95); // Consider nearly scrolled to end
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFE0000),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width * 0.075,
            MediaQuery.of(context).size.height * 0.0475,
            MediaQuery.of(context).size.width * 0.06,
            MediaQuery.of(context).size.height * 0.025,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Syarat dan Ketentuan',
                style: GlobalFont.giantfontR,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.01,
                ),
                child: Text(
                  'Mohon membaca dan menyetujui pernyataan dan persetujuan berikut untuk melanjutkan menggunakan aplikasi ini',
                  style: GlobalFont.bigfontMNormal,
                  textAlign: TextAlign.justify,
                  // 'Please read and agree to the following terms and conditions to continue using the app.',
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.01,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '1.',
                        style: GlobalFont.bigfontMNormal,
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Text(
                        'Saya menyatakan informasi data pribadi yang saya masukan pada sistem FixUP Moto adalah informasi dan data pribadi saya yang terbaru sistem dan sebenar-benarnya.',
                        style: GlobalFont.bigfontMNormal,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.01,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '2.',
                        style: GlobalFont.bigfontMNormal,
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Text(
                        'Saya menyatakan informasi data pribadi sebagimana tersebut diatas saya masukkan pada sistem FixUP Moto secara sadar tanpa ada paksaan dari pihak manapun.',
                        style: GlobalFont.bigfontMNormal,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.01,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '3.',
                        style: GlobalFont.bigfontMNormal,
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Text(
                        'Saya menyetujui dan bersedia menerima promosi produk dan broadcast penawaran produk dari FixUP Moto.',
                        style: GlobalFont.bigfontMNormal,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.01,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '4.',
                        style: GlobalFont.bigfontMNormal,
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Text(
                        'Saya menyetujui bahwa informasi data yang saya masukkan pada sistem FixUP Moto dapat dibagikan kepada pihak ke-3 (tiga) yang terafiliasi dengan FixUP Moto, untuk antara lain namun tidak terbatas pada keperluan promosi produk dan broadcast penawaran produk.',
                        style: GlobalFont.bigfontMNormal,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _isScrolledToEnd ? _onContinueClicked : null,
      //   tooltip: _isScrolledToEnd ? 'Continue' : 'Scroll to end',
      //   backgroundColor: _isScrolledToEnd ? Colors.green : Colors.grey,
      //   child: const Icon(Icons.arrow_forward),
      // ),
    );
  }

  void _onContinueClicked() {
    // Handle navigation to the next page or desired action
    Navigator.pushNamed(context, '/next_page');
  }
}
