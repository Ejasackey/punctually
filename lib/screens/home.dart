import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:punctually/cubit/month_cubit/cubit/month_cubit.dart';
import 'package:punctually/cubit/profile_cubit/cubit/profile_cubit.dart';
import 'package:punctually/cubit/qr_cubit/qr_cubit.dart';
import 'package:punctually/style.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QRCubit _qrCubit = context.read<QRCubit>();
    MonthCubit _monthCubit = context.read<MonthCubit>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<QRCubit, bool?>(
        bloc: _qrCubit,
        listenWhen: (prev, cur) {
          //only invoke listen callback when current state is false.
          if (cur == null || cur) {
            return false;
          } else {
            return true;
          }
        },
        listener: (context, state) async {
          await showScanStatus(context, state);
          _qrCubit.qrController!.resumeCamera();
        },
        child: SafeArea(
          child: Column(
            children: [
              profileSection(),
              const SizedBox(height: 20),
              const SizedBox(height: 50),
              BlocBuilder<QRCubit, bool?>(
                builder: (context, state) {
                  if (state == null || !state) {
                    return SizedBox(
                      height: 300,
                      width: 300,
                      child: QRView(
                        key: _qrCubit.qrKey,
                        onQRViewCreated: (controller) =>
                            _qrCubit.onQRViewCreated(
                                controller, context, "ZHLNbngdO2ITDOjo7c9S"),
                        overlay: QrScannerOverlayShape(
                          borderColor: primaryColor,
                          cutOutHeight: 290,
                          cutOutWidth: 290,
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.07),
                              offset: const Offset(1, 1),
                              blurRadius: 15)
                        ],
                      ),
                      child: statusDialog(state),
                    );
                  }
                },
              ),
              // scanButton(_qrCubit, context)
            ],
          ),
        ),
      ),
    );
  }

  // Scan Status Dialog Widget:---------------------------------------------------------------------
  Future showScanStatus(context, success) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        child: statusDialog(success),
      ),
    );
  }

  //---------------------------------------------------------------------------------
  SizedBox statusDialog(success) {
    return SizedBox(
      width: double.infinity,
      height: 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 80,
            backgroundColor:
                success ? Color(0xFFE0FFE9) : Colors.red.withOpacity(.1),
            child: Icon(
              success ? Icons.check_rounded : Icons.clear_rounded,
              size: 80,
              color: success ? Color(0xFF04A932) : Colors.redAccent,
            ),
          ),
          const SizedBox(height: 30),
          Text(
            success ? "Success" : "Invalid Code",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Colors.black.withOpacity(.75),
            ),
          ),
          const SizedBox(height: 20),
          if (success)
            Text(
              "Checked in today",
              style: TextStyle(color: Colors.grey[600]),
            )
        ],
      ),
    );
  }

  // Scan Button Widget:---------------------------------------------------------------------
  SizedBox scanButton(QRCubit _qrCubit, context) {
    return SizedBox(
      width: 250,
      child: ElevatedButton(
        onPressed: () => _qrCubit.scanQR(context),
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Scan QR",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(width: 10),
            Icon(Icons.qr_code_2_rounded, size: 32),
          ],
        ),
      ),
    );
  }

  // Profile Section Widget:---------------------------------------------------------------------
  Widget profileSection() {
    return Container(
      // margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      width: double.infinity,
      color: primaryColor,
      child: Row(
        children: [
          Container(
            height: 130,
            width: 130,
            decoration: BoxDecoration(
              color: Colors.yellow,
              image: ProfileCubit.me.profileUrl.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(
                        ProfileCubit.me.profileUrl,
                      ),
                      fit: BoxFit.cover,
                    )
                  : const DecorationImage(
                      image: AssetImage("assets/no_profile_img.jpg"),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ProfileCubit.me.name.isNotEmpty
                      ? ProfileCubit.me.name
                      : "Employee name",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  ProfileCubit.me.portfolio.isNotEmpty
                      ? ProfileCubit.me.portfolio
                      : "portfolio",
                  style: TextStyle(
                      fontSize: 16, color: Colors.white.withOpacity(.9)),
                ),
                const SizedBox(height: 5),
              ],
            ),
          )
        ],
      ),
    );
  }
}
