import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:punctually/cubit/month_cubit/cubit/month_cubit.dart';
import 'package:punctually/cubit/profile_cubit/cubit/profile_cubit.dart';
import 'package:punctually/cubit/qr_cubit/qr_cubit.dart';
import 'package:punctually/models/month.dart';
import 'package:punctually/screens/home.dart';
import 'package:punctually/style.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MonthAdapter());
  await Hive.openBox<Month>("months");
  await Hive.openBox("profile");
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileCubit>(
            create: (context) => ProfileCubit(profileBox: Hive.box("profile"))),
        BlocProvider<QRCubit>(create: (context) => QRCubit()),
        BlocProvider(
            create: (context) => MonthCubit(monthBox: Hive.box("months")))
      ],
      child: MaterialApp(
        title: 'Punctually',
        theme: ThemeData(
          // useMaterial3: true,
          colorScheme: ColorScheme.light(
            primary: primaryColor,
            secondary: accentLight,
          ),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
