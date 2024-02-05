import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import '../../../localization/locales.dart';
class NoElevatedButton extends StatelessWidget {
  const NoElevatedButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
            onPressed: () {
              
              Navigator.pop(context, true);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green),
            child: SizedBox(
              width: 60,
              child: Text(
                LocaleData.yes.getString(context),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ));
  }
}