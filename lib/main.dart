import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:punctually/cubit/month_cubit/cubit/month_cubit.dart';
import 'package:punctually/cubit/qr_cubit/qr_cubit.dart';
import 'package:punctually/firebase_options.dart';
import 'package:punctually/screens/login.dart';
import 'package:punctually/services/firebase_database.dart';
import 'package:punctually/style.dart';

void main() async {
  await Hive.initFlutter();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.openBox<DateTime>("scanStat");
  // await Hive.deleteFromDisk();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<QRCubit>(
          create: (context) => QRCubit(
              scanStatBox: Hive.box<DateTime>("scanStat"),
              firestoreService: FirestoreService()),
        ),
        BlocProvider(
            create: (context) =>
                MonthCubit(firestoreService: FirestoreService()))
      ],
      child: MaterialApp(
        title: 'Punctually',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // useMaterial3: true,
          colorScheme: ColorScheme.light(
            primary: primaryColor,
            secondary: accentLight,
          ),
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
