import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:punctually/cubit/qr_cubit/qr_cubit.dart';
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
    context.read<QRCubit>().reassemble();
  }

  @override
  Widget build(BuildContext context) {
    QRCubit _qrCubit = context.read<QRCubit>();
    
    return Scaffold(
      body: QRView(
        key: _qrCubit.qrKey,
        onQRViewCreated: (controller) =>
            _qrCubit.onQRViewCreated(controller, context),
        overlay: QrScannerOverlayShape(borderColor: primaryColor),
      ),
    );
  }
}
