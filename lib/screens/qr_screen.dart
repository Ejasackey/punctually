import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:punctually/cubit/qr_cubit/qr_cubit.dart';
import 'package:punctually/style.dart';

class QRScreen extends StatelessWidget {
  final String data;
  const QRScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    QRCubit _qrCubit = context.read<QRCubit>();

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(30.0),
      child: BarcodeWidget(
        barcode: Barcode.qrCode(),
        data: data,
      ),
    ));
  }
}
