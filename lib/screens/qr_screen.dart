import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:punctually/cubit/qr_cubit/qr_cubit.dart';
import 'package:punctually/style.dart';

class QRScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    QRCubit _qrCubit = context.read<QRCubit>();

    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: BarcodeWidget(
        barcode: Barcode.qrCode(),
        data: "something serious",
      ),
    ));
  }
}
