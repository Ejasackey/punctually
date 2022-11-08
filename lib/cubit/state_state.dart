part of 'state_cubit.dart';

@immutable
abstract class StateState {}

class StateInitial extends StateState {}

class ProfileState extends StateState {
  User? user;
  bool hasError;
  ProfileState({this.hasError = false, this.user});
}

class HomeScreenState extends StateState {
  bool scanStatus;
  HomeScreenState({required this.scanStatus});
}

class ReportScreenState extends StateState {
  Month month;
  ReportScreenState(this.month);
}
