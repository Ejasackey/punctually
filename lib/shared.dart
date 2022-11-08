import 'package:flutter/material.dart';
import 'package:punctually/style.dart';

navTo(context, Widget screen) {
  return Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}

roundedButton({context, icon, onPressed}) => SizedBox(
      height: 45,
      width: 45,
      child: TextButton(
        onPressed: onPressed ?? () => Navigator.maybePop(context),
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: accentLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
        child: icon ?? const Icon(Icons.chevron_left_rounded, size: 30),
      ),
    );
