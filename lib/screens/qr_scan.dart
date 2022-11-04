import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:punctually/cubit/state_cubit.dart';
import 'package:punctually/style.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  @override
  void reassemble() {
    super.reassemble();
    StateCubit.i.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QRView(
        key: StateCubit.qrKey,
        onQRViewCreated: (controller) =>
            StateCubit.i.onQRViewCreated(controller, context),
        overlay: QrScannerOverlayShape(
          borderColor: primaryColor,
        ),
      ),
    );
  }
}
