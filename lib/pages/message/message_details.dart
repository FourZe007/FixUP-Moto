import 'package:fixupmoto/global/model.dart';
import 'package:fixupmoto/indicator/progress%20bar/circleloading.dart';
import 'package:fixupmoto/widget/carousel/notification_length_notifier.dart';
import 'package:flutter/material.dart';
import 'package:fixupmoto/global/global.dart';
import 'package:fixupmoto/widget/format.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MessageDetail extends StatefulWidget {
  MessageDetail(this.index, {super.key});

  int index;

  @override
  State<MessageDetail> createState() => _MessageDetailState();
}

class _MessageDetailState extends State<MessageDetail> {
  List<ModelNotificationDetail> list = [];
  String returnValue = '';

  // ga dipake
  // void modifytMessageDetail() async {
  //   // setState(() => GlobalVar.isLoading = true);
  //   returnValue = await GlobalAPI.fetchModifyNotification(
  //     '2',
  //     'NOTIFICATION',
  //     GlobalVar.listNotificationDetail[widget.index].memberID,
  //     GlobalVar.listNotificationDetail[widget.index].notifID,
  //     GlobalVar.listNotificationDetail[widget.index].notifType,
  //     GlobalVar.listNotificationDetail[widget.index].notif,
  //     GlobalVar.listNotificationDetail[widget.index].isSent,
  //     '1',
  //   );
  //   if (returnValue ==
  //       GlobalVar.listNotificationDetail[widget.index].memberID) {
  //     list = await GlobalAPI.fetchGetNotification('1', '0');
  //     GlobalVar.listNotificationDetail = [];
  //     // NotificationChangeNotifier().notify(list);
  //   }
  //   // GlobalVar.listNotificationDetail =
  //   //     await GlobalAPI.fetchGetNotification('1', '1');
  //   // GlobalVar.notifLength = GlobalVar.listNotificationDetail.length;
  //   // for (int i = 0; i < GlobalVar.listNotificationDetail.length; i++) {
  //   //   if (i == widget.index) {
  //   //     list.add(GlobalVar.listNotificationDetail[i]);
  //   //     break;
  //   //   }
  //   // }
  //   // setState(() => GlobalVar.isLoading = false);
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // modifytMessageDetail();

    print('Index: ${widget.index}');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    list = [];
  }

  @override
  Widget build(BuildContext context) {
    GlobalVar.notifProviderLength =
        Provider.of<NotificationLengthChangeNotifier>(context);

    return WillPopScope(
      onWillPop: () async {
        // Prevent the default back button behavior
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Message Details',
            style: GlobalFont.giantfontM,
          ),
          // backgroundColor: const Color(0xFFF59842),
          // backgroundColor: Colors.red,
          // backgroundColor: const Color(0xFF99CCFF),
          backgroundColor: const Color(0xFFFE0000),
          leading: IconButton(
            onPressed: () {
              GlobalVar.notifProviderLength.notify();

              // Navigator.pop(context);
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            //replace with our own icon data.
          ),
        ),
        body: (GlobalVar.isLoading == true)
            ? const Center(
                child: CircleLoading(),
              )
            : Container(
                margin: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      GlobalVar.listNotificationDetail[widget.index].notifType,
                      style: GlobalFont.giantfontM,
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      Format.tanggalFormat(
                        GlobalVar.listNotificationDetail[widget.index].date,
                      ),
                      style: GlobalFont.middlegiantfontM,
                    ),
                    const SizedBox(height: 30.0),
                    Text(
                      GlobalVar.listNotificationDetail[widget.index].notif,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
