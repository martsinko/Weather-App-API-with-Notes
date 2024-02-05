import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import '../../../localization/locales.dart';
class YesElevatedButton extends StatelessWidget {
  const YesElevatedButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            style:
                ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: SizedBox(
              width: 60,
              child: Text(
                LocaleData.no.getString(context),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
            ));
  }
}
