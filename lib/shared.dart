import 'package:flutter/material.dart';

navTo(context, Widget screen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}
