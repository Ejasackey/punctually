import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:punctually/models/month.dart';
import 'package:punctually/models/user.dart';
import 'package:punctually/screens/qr_scan.dart';
import 'package:punctually/shared.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

part 'state_state.dart';

class StateCubit extends Cubit<StateState> {
  Box MonthsBox;
  Box profileBox;
  StateCubit._({required this.MonthsBox, required this.profileBox})
      : super(ProfileState(user: User.user));

  /// This instance is for testing purposes
  StateCubit.test(this.MonthsBox, this.profileBox) : super(ProfileState());
  static final i = StateCubit._(
    MonthsBox: Hive.box('months'),
    profileBox: Hive.box('profile'),
  );

  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }

  static final ImagePicker _picker = ImagePicker();
  static final GlobalKey qrKey = GlobalKey(debugLabel: "QR");
  Barcode? result;
  QRViewController? _qrController;

  getImage() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // emit(ProfileState(user));
      profileBox.put("profileUrl", image.path);
      getProfile();
    } else {}
  }

  saveProfile() {}

  getProfile() {
    User user = User();
    user.name = profileBox.get("name");
    user.portfolio = profileBox.get("portfolio");
    user.department = profileBox.get("department");
    user.profileUrl = profileBox.get("profileUrl");
    emit(ProfileState(user: user));
  }

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
    PermissionStatus status = await _getCameraPermission();
    if (status.isGranted) {
      bool success = await navTo(context, QRScannerScreen());
      emit(HomeScreenState(scanStatus: success));
    }
  }

  Month getMonthDetailData() {
    Month.thisMonth.days.removeWhere((key, value) {
      return key.weekday == 6 || key.weekday == 7;
    });

    return Month.thisMonth;
  }

  getPercentage(Month month) {
    int att = month.days.values.where((value) => value == true).length;
    return (att / month.days.values.length);
  }
}
