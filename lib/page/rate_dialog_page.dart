import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:rate_my_app_example/widget/button_widget.dart';

class RateDialogPage extends StatefulWidget {
  final RateMyApp rateMyApp;

  const RateDialogPage({
    Key? key,
    required this.rateMyApp,
  }) : super(key: key);

  @override
  _RateDialogPageState createState() => _RateDialogPageState();
}

class _RateDialogPageState extends State<RateDialogPage> {
  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.all(48),
        child: Center(
          child: ButtonWidget(
            text: 'Rate App',
            onClicked: () => widget.rateMyApp.showRateDialog(context),
          ),
        ),
      );
}
