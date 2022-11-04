part of 'state_cubit.dart';

@immutable
abstract class StateState {}

class StateInitial extends StateState {}

class ProfileImageState extends StateState {
  File? image;
  bool hasError;
  ProfileImageState({this.image, this.hasError = false});
}

class HomeScreenState extends StateState {
  bool scanStatus;
  HomeScreenState({required this.scanStatus});
}

class ReportScreenState extends StateState {
  Month month;
  ReportScreenState(this.month);
}
