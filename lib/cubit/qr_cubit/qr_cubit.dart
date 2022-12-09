import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:punctually/services/firebase_database.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

part 'qr_state.dart';

class QRCubit extends Cubit<bool?> {
  FirestoreService firestoreService;
  Box<DateTime> scanStatBox;
  QRCubit({required this.scanStatBox, required this.firestoreService})
      : super(null) {
    // if scanned and it's still today. emit true
    DateTime lastScanDate = scanStatBox.get(
      "status",
      defaultValue: DateTime.now().subtract(const Duration(days: 1)),
    )!;

    log(lastScanDate.toString());

    if (lastScanDate.day == DateTime.now().day) {
      //Already scanned today.
      emit(true);
    }

    // if scanned and it's was yesterday emit null
    // if not scanned and it's still today, emit null;
  }

  final GlobalKey qrKey = GlobalKey(debugLabel: "QR");
  Barcode? result;
  QRViewController? qrController;

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
      qrController!.pauseCamera();
    } else if (Platform.isIOS) {
      qrController!.resumeCamera();
    }
  }

  //--------------------------------------------------------------------------------------------
  Future registerAttendance(userId, value) async {
    try {
      await firestoreService.registerAttendance(userId, value);
    } catch (e) {
      log(e.toString(), name: "QR cubit: registerAttendance");
      throw e;
    }
  }

  //--------------------------------------------------------------------------------------------
  onQRViewCreated(QRViewController controller, context, String userId) async {
    qrController = controller;
    PermissionStatus status = await _getCameraPermission();
    if (status.isGranted) {
      controller.scannedDataStream.listen(
        (scanData) async {
          emit(null);
          log(scanData.code!);
          controller.pauseCamera();
          if (scanData.code! == "I Love You") {
            try {
              await registerAttendance(userId, "L");
              scanStatBox.put("status", DateTime.now());
              emit(true);
            } catch (e) {
              // TODO: show snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text("Coudn't connect, check internet and try again"),
                ),
              );
              // emit(null);
            }
          } else {
            emit(false);
          }
        },
      );
    }
  }

  //--------------------------------------------------------------------------------------------
  scanQR(context) async {
    // emit(null);
    // PermissionStatus status = await _getCameraPermission();
    // if (status.isGranted) {
    //   bool success = await navTo(context, QRScannerScreen());
    //   emit(success);
    // }
  }

  @override
  Future<void> close() {
    qrController!.dispose();
    return super.close();
  }
}
