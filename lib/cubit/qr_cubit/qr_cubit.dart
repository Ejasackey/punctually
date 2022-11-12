import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:punctually/screens/qr_scan.dart';
import 'package:punctually/shared.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

part 'qr_state.dart';

class QRCubit extends Cubit<bool?> {
  QRCubit() : super(null);

  final GlobalKey qrKey = GlobalKey(debugLabel: "QR");
  Barcode? result;
  QRViewController? _qrController;

  Future<PermissionStatus> _getCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      return await Permission.camera.request();
    } else {
      return status;
    }
  }

  reassemble() {
    if (Platform.isAndroid) {
      _qrController!.pauseCamera();
    } else if (Platform.isIOS) {
      _qrController!.resumeCamera();
    }
  }

  onQRViewCreated(QRViewController controller, context) {
    this._qrController = controller;
    controller.scannedDataStream.listen((scanData) {
      log(scanData.code!);
      controller.stopCamera();
      controller.dispose();
      Navigator.of(context).pop(true);
    });
  }

  scanQR(context) async {
    emit(null);
    PermissionStatus status = await _getCameraPermission();
    if (status.isGranted) {
      bool success = await navTo(context, QRScannerScreen());
      emit(success);
    }
  }

  

  
}
