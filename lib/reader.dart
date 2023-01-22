// import 'dart:io';
// import 'package:device_info/device_info.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_dropdown_alert/alert_controller.dart';
// import 'package:flutter_dropdown_alert/model/data_alert.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
//
//
//
//
// const flashOn = 'FLASH ON';
// const flashOff = 'FLASH OFF';
// const frontCamera = 'FRONT CAMERA';
// const backCamera = 'BACK CAMERA';
//
// class QRViewExample extends StatefulWidget {
//   const QRViewExample({super.key});
//
//   @override
//   State<StatefulWidget> createState() => _QRViewExampleState();
// }
//
// class _QRViewExampleState extends State<QRViewExample> {
//   var flashState = flashOn;
//   var cameraState = frontCamera;
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   Barcode? result;
//   QRViewController? controller;
//
//   @override
//   void reassemble() {
//     super.reassemble();
//     if (Platform.isAndroid) {
//       controller!.pauseCamera();
//     } else if (Platform.isIOS) {
//       controller!.resumeCamera();
//     }
//   }
//
//   Future<String> getDeviceUUID() async {
//     return Platform.isAndroid ? (await DeviceInfoPlugin().androidInfo).androidId : (await DeviceInfoPlugin().iosInfo).identifierForVendor;
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       child: SafeArea(
//         child: Scaffold(
//           body: Stack(
//             alignment: Alignment.center,
//             children: <Widget>[
//               SizedBox(
//                   height: MediaQuery.of(context).size.height,
//                   width: MediaQuery.of(context).size.width,
//                   child: QRView(
//                     key: qrKey,
//                     onQRViewCreated: (QRViewController controller) {
//                       this.controller = controller;
//                       controller.scannedDataStream.listen((scanData) async{
//                         setState(() {
//                           result = scanData;
//                         });
//                         result != null ? controller.pauseCamera() : null;
//                         final String deviceUUID = await getDeviceUUID();
//                             AlertController.show("deviceUUID", "يرجى اعادة المحاولة مرة ثانية!", TypeAlert.error);
//                       });
//                       controller.pauseCamera();
//                       controller.resumeCamera();
//                       },
//                     overlay: QrScannerOverlayShape(
//                       borderColor: const Color(0xffc32328),
//                       borderRadius: 10,
//                       borderLength: 30,overlayColor: Colors.black87,
//                       borderWidth: 5,
//                       cutOutSize: (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? 300.0 : 300.0,
//                     ),
//                   )
//               ),
//               Positioned(
//                 bottom: 100,
//                 child: InkWell(
//                     onTap: (){
//                       Navigator.of(context).pop();
//                     },
//                     child: const Icon(Icons.close,color: Colors.red,size: 35,)),
//               ),
//               Positioned(
//                 top: 120,
//                 child: Container(
//                   margin: const EdgeInsets.all(8),
//                   child: IconButton(
//                     icon: Icon(flashState == "FLASH ON" ?  Icons.light : Icons.light,color: flashState != "FLASH ON" ? Colors.yellowAccent : Colors.grey,size: 35,),
//                     onPressed: () {
//                       controller?.toggleFlash();
//                       if (_isFlashOn(flashState)) {
//                         setState(() {
//                           flashState = flashOff;
//                         });
//                       } else {
//                         setState(() {
//                           flashState = flashOn;
//                         });
//                       }
//                     },
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 30),
//                 child: Container(
//                 height: 350,width: 350,
//                 margin: const EdgeInsets.only(left: 10),
//                 child: Lottie.asset(
//                   'assets/icons/redLine.json',
//                   height: 100,
//                   animate: true,
//                   repeat: true,
//                 ),
//                 ),
//               )
//               // Positioned(
//               //     bottom: 50,
//               //     child: Text('${result?.code}',style: const TextStyle(color: Colors.white),)
//               // )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   bool _isFlashOn(String current) {
//     return flashOn == current;
//   }
//
//
//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }